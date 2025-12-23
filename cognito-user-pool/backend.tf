terraform {
  backend "s3" {
    key            = "esportes-hub/cognito-user-pool/terraform.tfstate" # Path to the state file inside the bucket
    bucket         = "terraform-backend-prod-terraform-state"           # Replace with your S3 bucket name
    region         = "us-east-1"                                        # S3 bucket region
    encrypt        = true                                               # Encrypt the state file
    dynamodb_table = "terraform-backend-prod-terraform-state-lock"      # DynamoDB table for locking
  }
}
