locals {
  service_full_name = "${var.service_name}-${var.stage}"
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}

# Get Route53 Zone
data "aws_route53_zone" "domain_zone" {
  name         = "${var.route53_zone_domain}."
  private_zone = var.route53_private_zone
}

# Resource group
resource "aws_resourcegroups_group" "service" {
  name = local.service_full_name

  resource_query {
    query = <<JSON
    {
      "ResourceTypeFilters": ["AWS::AllSupported"],
      "TagFilters": [
        {
          "Key": "Service",
          "Values": ["${local.service_full_name}"]
        }
      ]
    }
    JSON
  }

  tags = {
    Name = "${local.service_full_name}-rg"
  }
}

# VPC connector
resource "aws_apprunner_vpc_connector" "connector" {
  vpc_connector_name = "name"
  subnets            = ["subnet1", "subnet2"]
  security_groups    = ["sg1", "sg2"]
}

# Service App Runner
resource "aws_apprunner_service" "service" {
  count = var.create_apprunner_service ? 1 : 0

  service_name                   = local.service_full_name
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.autoscalling.arn

  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = var.vpc_connector_arn != null ? var.vpc_connector_arn : null
    }
  }

  health_check_configuration {
    healthy_threshold   = var.service_healthcheck_healthy_threshold
    unhealthy_threshold = var.service_healthcheck_unhealthy_threshold
    timeout             = var.service_healthcheck_timeout
    interval            = var.service_healthcheck_interval
    path                = var.service_healthcheck_path
    protocol            = var.service_healthcheck_protocol
  }

  source_configuration {
    auto_deployments_enabled = var.auto_deployments_enabled

    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner_ecr_access_role.arn
    }

    image_repository {
      image_identifier      = "${aws_ecr_repository.registry.repository_url}:${var.image_tag}"
      image_repository_type = "ECR"

      image_configuration {
        port          = var.service_port
        start_command = var.start_command != null ? var.start_command : null

        runtime_environment_variables = var.environment_variables
        runtime_environment_secrets   = var.ssm_secrets
      }
    }
  }

  instance_configuration {
    cpu    = var.instance_cpu
    memory = var.instance_memory

    # Add IAM role for the instance to access SSM
    instance_role_arn = aws_iam_role.apprunner_instance_role.arn
  }

  depends_on = [
    aws_iam_role_policy_attachment.apprunner_ecr_access_policy,
    aws_iam_role_policy_attachment.apprunner_ssm_access_policy,
    aws_ecr_repository.registry,
  ]

  tags = {
    "Name" = "${local.service_full_name}-apprunner"
  }
}

# IAM Role for App Runner to access ECR
resource "aws_iam_role" "apprunner_ecr_access_role" {
  name = "${local.service_full_name}-apprunner-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "build.apprunner.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "${local.service_full_name}-apprunner-ecr-role"
  }
}

# Attach manager policy to allow ECR access
resource "aws_iam_role_policy_attachment" "apprunner_ecr_access_policy" {
  role       = aws_iam_role.apprunner_ecr_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

# Auto-scaling configuration for App Runner
resource "aws_apprunner_auto_scaling_configuration_version" "autoscalling" {
  auto_scaling_configuration_name = "${local.service_full_name}-as"
  max_concurrency                 = var.autoscalling_max_concurrency
  min_size                        = var.autoscalling_min_size
  max_size                        = var.autoscalling_max_size
  tags = {
    Name = "${local.service_full_name}-as"
  }
}

# Image registry
resource "aws_ecr_repository" "registry" {
  name = var.registry_name != null ? var.registry_name : "${local.service_full_name}-registry"

  image_tag_mutability = var.registry_tag_mutability


  image_scanning_configuration {
    scan_on_push = var.registry_scan_on_push
  }

  tags = {
    Name = "${local.service_full_name}-registry"
  }
}

# SSM
# IAM Role for App Runner instance to access SSM
resource "aws_iam_role" "apprunner_instance_role" {
  name = "${local.service_full_name}-apprunner-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "tasks.apprunner.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${local.service_full_name}-apprunner-instance-role"
  }
}

# Policy to allow access to SSM Parameter Store
resource "aws_iam_policy" "ssm_access_policy" {
  name        = "${local.service_full_name}-ssm-access-policy"
  description = "Policy to allow App Runner to access SSM parameters"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:GetParameters",
          "ssm:GetParameter"
        ]
        Effect = "Allow"
        Resource = [
          for param_name in values(var.ssm_secrets) :
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter${param_name}"
        ]
      }
    ]
  })

  tags = {
    Name = "${local.service_full_name}-ssm-access-policy"
  }
}

resource "aws_iam_role_policy_attachment" "apprunner_ssm_access_policy" {
  role       = aws_iam_role.apprunner_instance_role.name
  policy_arn = aws_iam_policy.ssm_access_policy.arn
}
