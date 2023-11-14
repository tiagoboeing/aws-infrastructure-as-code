terraform {
	required_providers {
		aws = {
      source  = "hashicorp/aws"
	    version = "~> 5.25.0"
		}
  }
}


provider "aws" {
  skip_credentials_validation = true
}
