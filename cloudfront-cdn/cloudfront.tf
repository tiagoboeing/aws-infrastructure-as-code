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
  default_root_object = var.cloudfront_default_root_object
  http_version        = var.cloudfront_http_version

  aliases = local.cdn_domain != "" ? [local.cdn_domain] : local.route53_base_domain != "" ? [local.route53_base_domain] : []

  origin {
    origin_id                = aws_s3_bucket.bucket.id
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_acl.id
    domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
  }

  default_cache_behavior {
    target_origin_id = aws_s3_bucket.bucket.id

    compress        = true
    allowed_methods = var.cloudfront_allowed_methods
    cached_methods  = var.cloudfront_cached_methods

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
    cloudfront_default_certificate = false

    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"

    acm_certificate_arn = aws_acm_certificate_validation.certificate_validation.certificate_arn
  }


  tags = {
    Stage   = local.stage,
    Service = local.service
  }

  depends_on = [
    aws_s3_bucket.bucket
  ]
}

# Create Route53 Record to CloudFront
resource "aws_route53_record" "domain_record" {
  name    = local.cdn_domain != "" ? local.cdn_domain : data.aws_route53_zone.domain_zone.name
  type    = "A"
  zone_id = data.aws_route53_zone.domain_zone.zone_id

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [
    aws_cloudfront_distribution.cloudfront
  ]
}
