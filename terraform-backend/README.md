# Terraform Backend

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

Remote state backend infrastructure for Terraform using AWS S3 and DynamoDB. This module creates the necessary infrastructure to store Terraform state remotely and securely, including state locking to prevent concurrent modifications.

> [!IMPORTANT]
> This is a foundational component that should be created before other infrastructure resources. This module must be run with local state initially, as it's creating its own backend.

## Stack

- S3 Bucket (state storage)
- DynamoDB Table (state locking)
- Amazon Certificate Manager

### S3 Bucket
- **Name**: `${service_name}-${stage}-terraform-state`
- **Versioning**: Enabled to maintain state history
- **Encryption**: AES256 by default
- **Public Access**: Completely blocked
- **Deletion Protection**: Enabled via `prevent_destroy`

### DynamoDB Table
- **Name**: `${service_name}-${stage}-terraform-state-lock`
- **Billing Mode**: Pay per request
- **Hash Key**: `LockID`
- **Purpose**: State locking concurrency control

## Pricing

In most cases, the price will be near to zero for small projects. 

The pricing is based on:
- S3: Storage ($0.023 per GB) and requests
- DynamoDB: Pay-per-request pricing ($1.25 per million writes, $0.25 per million reads)

See [AWS S3 Pricing](https://aws.amazon.com/s3/pricing/) and [AWS DynamoDB Pricing](https://aws.amazon.com/dynamodb/pricing/) for more details.

> [!NOTE]
> For production workloads, monitor your usage. Versioning enabled on S3 will increase storage costs over time.

## Requirements

- AWS CLI configured
- Terraform >= 1.0
- AWS credentials with permissions for:
  - S3 (CreateBucket, PutBucketPolicy, PutBucketVersioning, etc.)
  - DynamoDB (CreateTable, DescribeTable, etc.)

## Supported variables

| Name           | Type     | Default     | Description                                |
| -------------- | -------- | ----------- | ------------------------------------------ |
| `region`       | `string` | `us-east-1` | AWS region where resources will be created |
| `service_name` | `string` | `cluster`   | Service name (used in resource naming)     |
| `stage`        | `string` | `dev`       | Environment (dev, test, prod, etc.)        |

## Usage

### 1. Configure variables

Copy the example file and configure your variables:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit the `terraform.tfvars` file:

```hcl
service_name = "your-service-name"
stage        = "prod"
```

### 2. Deploy the backend infrastructure

```bash
# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply changes
terraform apply
```

### 3. Configure remote backend in other modules

After creating the infrastructure, configure other modules to use this backend:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-service-name-prod-terraform-state"
    key            = "path/to/your/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "your-service-name-prod-terraform-state-lock"
    encrypt        = true
  }
}
```

### 4. Migrate existing state (if needed)

If you already have local state and want to migrate to this backend:

```bash
# 1. Create the backend infrastructure (this module)
terraform apply

# 2. Add backend configuration to other modules
# 3. Run migration
terraform init -migrate-state
```

## Outputs

| Name                  | Description                                  |
| --------------------- | -------------------------------------------- |
| `s3_bucket_name`      | Name of the S3 bucket                        |
| `s3_bucket_arn`       | ARN of the S3 bucket                         |
| `s3_bucket_region`    | Region of the S3 bucket                      |
| `dynamodb_table_name` | Name of the DynamoDB table for state locking |
| `dynamodb_table_arn`  | ARN of the DynamoDB table                    |

## Security

This module implements the following security best practices:

- ✅ **Encryption**: State encrypted at rest (AES256)
- ✅ **Versioning**: State version history
- ✅ **Public Access Blocked**: No public access to the bucket
- ✅ **State Locking**: Prevents concurrent modifications
- ✅ **Deletion Protection**: Bucket protected against accidental deletion
- ✅ **Tagging**: Default tags applied for governance

## Troubleshooting

### Permission Errors
If you receive permission errors, verify that your AWS credentials have the necessary permissions listed in the requirements.

### Name Conflict
If the S3 bucket already exists, change the `service_name` or `stage` to generate a unique name.

### Corrupted State
S3 versioning allows you to recover previous versions of the state in case of issues.

### Destroying the Infrastructure

The S3 bucket has deletion protection enabled. To completely destroy the infrastructure:

1. Remove the `prevent_destroy` lifecycle rule from the S3 bucket in `main.tf`
2. Run `terraform apply` to update the configuration
3. Run `terraform destroy`