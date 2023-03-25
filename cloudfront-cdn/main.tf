locals {
  service              = "tf-cdn"
  stage                = "dev"
  resource_prefix_name = "${local.service}-${local.stage}"

  route53_create_domain = true
  route53_private_zone  = false

  # the hosted zone domain name
  route53_base_domain = "tiagoboeing.com"

  # Where you want to deploy the CloudFront distribution
  # leave empty to deploy inside base domain
  cdn_domain = "terraform.tiagoboeing.com"
}

data "aws_caller_identity" "current" {}

# Route53
data "aws_route53_zone" "domain_zone" {
  name         = "${local.route53_base_domain}."
  private_zone = local.route53_private_zone
}

resource "aws_route53_record" "domain_record" {
  name    = local.cdn_domain != "" ? local.cdn_domain : data.aws_route53_zone.domain_zone.name
  type    = "AAAA"
  zone_id = data.aws_route53_zone.domain_zone.zone_id

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }

  count = local.route53_create_domain ? 1 : 0

  depends_on = [
    aws_cloudfront_distribution.cloudfront
  ]
}

# ACM
resource "aws_acm_certificate" "certificate" {
  domain_name       = local.cdn_domain != "" ? local.cdn_domain : data.aws_route53_zone.domain_zone.name
  validation_method = "DNS"

  count = local.route53_create_domain ? 1 : 0
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate[0].arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_records : record.fqdn]

  depends_on = [
    aws_acm_certificate.certificate
  ]

  timeouts {
    create = "10m"
  }
}

# Add Certificate Validation Records on Route53
resource "aws_route53_record" "certificate_records" {
  for_each = {
    for dvo in aws_acm_certificate.certificate[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.domain_zone.zone_id
}

# CloudFront
resource "aws_cloudfront_origin_access_control" "cloudfront_acl" {
  name = "ACL - ${local.resource_prefix_name}"

  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cloudfront" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CDN for ${local.resource_prefix_name}"
  default_root_object = "index.html"
  http_version        = "http2"

  aliases = local.cdn_domain != "" ? [local.cdn_domain] : local.route53_base_domain != "" ? [local.route53_base_domain] : []

  origin {
    origin_id                = aws_s3_bucket.bucket.id
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_acl.id
    domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
  }

  default_cache_behavior {
    target_origin_id = aws_s3_bucket.bucket.id

    compress        = true
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = local.route53_create_domain ? false : true

    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = local.route53_create_domain ? "sni-only" : null

    acm_certificate_arn = local.route53_create_domain ? aws_acm_certificate_validation.certificate_validation.certificate_arn : null
  }


  tags = {
    Stage = local.stage
  }

  depends_on = [
    aws_s3_bucket.bucket
  ]
}

# S3
resource "aws_s3_bucket" "bucket" {
  bucket = "${local.resource_prefix_name}-bucket-${data.aws_caller_identity.current.account_id}"

  tags = {
    Stage = local.stage
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipalReadOnly",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com",
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceArn" : aws_cloudfront_distribution.cloudfront.arn
          }
        }
      }
    ]
  })

  depends_on = [
    aws_s3_bucket.bucket
  ]
}

#############################
# Only for tests purposes
#############################
resource "aws_s3_object" "public_folder" {
  for_each     = fileset("public/", "*")
  bucket       = aws_s3_bucket.bucket.id
  key          = each.value
  source       = "public/${each.value}"
  etag         = filemd5("public/${each.value}")
  content_type = "text/html"
}

resource "null_resource" "cache_invalidation" {

  # prevent invalidating cache before new s3 file is uploaded
  depends_on = [
    aws_s3_object.public_folder
  ]

  for_each = fileset("${path.module}/public/", "**")

  triggers = {
    hash = filemd5("public/${each.value}")
  }

  provisioner "local-exec" {
    # sleep is necessary to prevent throttling when invalidating many files; a dynamic sleep time would be more reliable
    # possible way of dealing with parallelism (though would lose the indiviual triggers): https://discuss.hashicorp.com/t/specify-parallelism-for-null-resource/20884/2
    command = "sleep 1; aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.cloudfront.id} --paths '/${each.value}'"
  }
}
