locals {
  resource_prefix_name = "terraform_eks"
}

# IAM
resource "aws_iam_policy" "iam_policy" {
  name        = "${locals.resource_prefix_name}-policy"
  description = "IAM policy to ${locals.resource_prefix_name}"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]

}
EOT
}

# ECR
resource "aws_ecr_repository" "ecr_repository" {
  name = "${locals.resource_prefix_name}_ecr"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_registry_policy" "ecr_policy" {
  policy = aws_iam_policy.iam_policy
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle" {
  repository = aws_ecr_repository.ecr_repository

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

# EKS
