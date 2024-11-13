provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      version = "~> 5.75.1"
    }
  }
}
