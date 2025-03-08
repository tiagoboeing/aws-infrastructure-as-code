locals {
  service              = var.service
  stage                = var.stage
  resource_prefix_name = "${var.service}-${var.stage}"
  route53_private_zone = var.route53_private_zone
  route53_base_domain  = var.route53_zone_domain
  cdn_domain           = var.cdn_domain
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}

# Get Route53 Zone
data "aws_route53_zone" "domain_zone" {
  name         = "${local.route53_base_domain}."
  private_zone = local.route53_private_zone
}

# Resource group
resource "aws_resourcegroups_group" "service" {
  name = local.resource_prefix_name

  resource_query {
    query = <<JSON
    {
      "ResourceTypeFilters": ["AWS::AllSupported"],
      "TagFilters": [
        {
          "Key": "Service",
          "Values": ["${local.resource_prefix_name}"]
        }
      ]
    }
    JSON
  }

  tags = {
    Name = "${local.resource_prefix_name}-rg"
  }
}




