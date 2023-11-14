resource "random_string" "hash" {
  length  = 6
  special = false
}

# Cognito self domain
resource "aws_cognito_user_pool_domain" "main" {
  user_pool_id = aws_cognito_user_pool.pool.id

  domain          = var.domain != "" ? var.domain : join("-", [aws_cognito_user_pool.pool.name, lower(random_string.hash.result)])
  certificate_arn = var.domain != "" ? aws_acm_certificate.certificate.arn : null

  depends_on = [
    aws_acm_certificate.certificate
  ]
}


# Custom domain
resource "aws_route53_record" "auth-cognito-A" {
  name    = aws_cognito_user_pool_domain.main.domain
  type    = "A"
  zone_id = data.aws_route53_zone.domain_zone.zone_id

  alias {
    evaluate_target_health = false

    name    = aws_cognito_user_pool_domain.main.cloudfront_distribution
    zone_id = aws_cognito_user_pool_domain.main.cloudfront_distribution_zone_id
  }
}
