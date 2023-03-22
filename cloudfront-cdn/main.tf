locals {
  service              = "tf-cdn"
  stage                = "dev"
  resource_prefix_name = "${local.service}-${local.stage}"
  domain_name          = "example.com"
}

data "aws_caller_identity" "current" {}

# IAM
# TODO: Create a role for CloudFront to assume

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

  # aliases = [
  #   local.domain_name
  # ]

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
    cloudfront_default_certificate = true
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
  bucket = "${local.resource_prefix_name}-cdn-${data.aws_caller_identity.current.account_id}"

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
