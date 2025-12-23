terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

provider "aws" {
  region                      = var.region
  skip_credentials_validation = true

  default_tags {
    tags = {
      Service     = local.service_full_name # Will be: ${service_name}-${stage}
      ServiceName = var.service_name
      Stage       = var.stage
    }
  }
}