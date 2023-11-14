locals {
  stage                = var.stage != "" ? var.stage : "dev"
  resource_prefix_name = "${var.pool_name}-${var.stage}"
  route53_base_domain  = var.route53_zone_domain
}


# Get AWS Account ID
data "aws_caller_identity" "current" {}

# Get Route53 Zone
data "aws_route53_zone" "domain_zone" {
  name         = "${local.route53_base_domain}."
  private_zone = var.route53_private_zone
}
