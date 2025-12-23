provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Service     = local.service_full_name # Will be: ${service_name}-${stage}
      ServiceName = var.service_name
      Stage       = var.stage
    }
  }
}

locals {
  service_full_name = "${var.service_name}-${var.stage}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${local.service_full_name}-terraform-state"

  # Prevent accidental deletion of the bucket
  lifecycle {
    prevent_destroy = true
  }
  
  tags = {
    Name = "${local.service_full_name}-terraform-state"
  }
}

# Enable versioning to maintain state history
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.bucket.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable default encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "dynamo" {
  name         = "${local.service_full_name}-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "${local.service_full_name}-terraform-locks"
  }
}