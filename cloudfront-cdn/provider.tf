terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
}

provider "aws" {
  skip_credentials_validation = true

  default_tags {
    tags = {
      Service     = local.resource_prefix_name # Will be: ${service_name}-${stage}
      ServiceName = local.service
      Stage       = local.stage
    }
  }
}
