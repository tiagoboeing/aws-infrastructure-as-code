# Get Route53 Zone
data "aws_route53_zone" "domain_zone" {
  name         = "${var.route53_base_domain}."
  private_zone = var.route53_private_zone
}

# Resources
resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain != "" ? var.domain : data.aws_route53_zone.domain_zone.name
  validation_method = "DNS"

  tags = {
    Name = var.service_name
  }
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
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
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
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
