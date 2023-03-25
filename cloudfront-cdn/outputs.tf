output "aws_cloudfront_default_domain" {
  value = aws_cloudfront_distribution.cloudfront.domain_name
}

output "cdn_domain" {
  value = local.cdn_domain != "" ? local.cdn_domain : data.aws_route53_zone.domain_zone.name
}
