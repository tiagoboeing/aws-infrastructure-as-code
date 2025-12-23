# Data source for AWS managed CloudFront cache policy
data "aws_cloudfront_cache_policy" "managed_caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_origin_request_policy" "managed_all_viewer_except_host_header" {
  name = "Managed-AllViewerExceptHostHeader"
}

resource "aws_cloudfront_response_headers_policy" "response_headers_policy" {
  name    = "${local.service_full_name}-response-headers-policy"
  comment = "Response headers policy for ${local.service_full_name} to handle CORS"

  cors_config {
    origin_override                  = false
    access_control_max_age_sec       = var.cors_max_age_seconds
    access_control_allow_credentials = var.cors_allow_credentials
    access_control_allow_origins {
      items = var.cors_allow_origins
    }

    access_control_allow_headers {
      items = var.cors_allow_headers
    }

    access_control_allow_methods {
      items = var.cors_allow_methods
    }

    access_control_expose_headers {
      items = var.cors_expose_headers
    }
  }
}

resource "aws_cloudfront_distribution" "cloudfront" {
  count = var.create_apprunner_service ? 1 : 0

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Edge for ${local.service_full_name}"
  default_root_object = var.cloudfront_default_root_object
  http_version        = var.cloudfront_http_version
  aliases             = var.api_domain != "" ? [var.api_domain] : var.route53_zone_domain != "" ? [var.route53_zone_domain] : []

  origin {
    origin_id   = "apprunner"
    domain_name = aws_apprunner_service.service[0].service_url

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id           = "apprunner"
    smooth_streaming           = true
    compress                   = true
    allowed_methods            = var.cloudfront_allowed_methods
    cached_methods             = var.cloudfront_cached_methods
    cache_policy_id            = data.aws_cloudfront_cache_policy.managed_caching_disabled.id
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.managed_all_viewer_except_host_header.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.response_headers_policy.id
    viewer_protocol_policy     = "redirect-to-https"
    min_ttl                    = 0
    default_ttl                = 0
    max_ttl                    = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
    acm_certificate_arn            = aws_acm_certificate_validation.certificate_validation.certificate_arn
  }

  tags = {
    Name = "${local.service_full_name}-cloudfront"
  }

  depends_on = [
    aws_apprunner_service.service
  ]
}

# Create Route53 Record to CloudFront
resource "aws_route53_record" "domain_record" {
  count = var.create_apprunner_service ? 1 : 0

  name    = var.api_domain != "" ? var.api_domain : data.aws_route53_zone.domain_zone.name
  type    = "A"
  zone_id = data.aws_route53_zone.domain_zone.zone_id

  alias {
    name                   = aws_cloudfront_distribution.cloudfront[0].domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront[0].hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [
    aws_cloudfront_distribution.cloudfront
  ]
}
