terraform {
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
      "service" = "cluster-dev"
      "stage"   = var.stage
    }
  }
}
