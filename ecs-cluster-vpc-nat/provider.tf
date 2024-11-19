terraform {
  required_version = ">= 1.9.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.1"
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
