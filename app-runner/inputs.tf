variable "region" {
  default     = "us-east-1"
  description = "AWS region where the resources will be created"
  type        = string
}

variable "service_name" {
  default     = "cluster"
  description = "Service name"
  type        = string
  nullable    = false
}

variable "stage" {
  default     = "dev"
  description = "Stage (e.g. dev, test, prod)"
  type        = string
}

# App runner
variable "environment_variables" {
  description = "Environment variables for the App Runner service"
  type        = map(string)
  default     = {}
}

variable "ssm_secrets" {
  description = "Map of environment variable names to SSM parameter names for secrets"
  type        = map(string)
  default     = {}
  sensitive   = true
  # Eg.: { "DATABASE_PASSWORD" = "/app/db/password" }
}

variable "create_apprunner_service" {
  default     = false
  description = "Set to true to create the App Runner service. Set to false to skip it (useful when you need to push an image to ECR first)."
  type        = bool
}

variable "service_port" {
  default     = "3000"
  description = "Port on which the service will run"
  type        = string
}

variable "start_command" {
  default     = null
  description = "Start command for the App Runner service (optional)"
  type        = string
}

variable "auto_deployments_enabled" {
  default     = true
  description = "Enable auto deployments for the App Runner service"
  type        = bool
  nullable    = true
}

variable "service_healthcheck_path" {
  default     = "/"
  description = "Health check path for the App Runner service"
  type        = string
}
variable "service_healthcheck_protocol" {
  default     = "TCP"
  description = "Health check protocol for the App Runner service"
  type        = string
}

variable "service_healthcheck_timeout" {
  default     = 10
  description = "Health check timeout in seconds for the App Runner service"
  type        = number
}

variable "service_healthcheck_interval" {
  default     = 20
  description = "Health check interval in seconds for the App Runner service"
  type        = number
}

variable "service_healthcheck_healthy_threshold" {
  default     = 1
  description = "Number of consecutive successful health checks required to consider the service healthy"
  type        = number
}

variable "service_healthcheck_unhealthy_threshold" {
  default     = 5
  description = "Number of consecutive failed health checks required to consider the service unhealthy"
  type        = number
}

# Instance configuration variables
variable "image_tag" {
  default     = "latest"
  description = "Tag for the Docker image in the ECR repository"
  type        = string
}

variable "instance_cpu" {
  default     = "0.5 vCPU"
  description = "CPU configuration for the App Runner instance"
  type        = string
}

variable "instance_memory" {
  default     = "1024"
  description = "Memory configuration for the App Runner instance in MB"
  type        = string
}

# Auto-scaling configuration variables
variable "autoscalling_max_concurrency" {
  default     = 200
  description = "Maximum concurrency for auto-scaling"
  type        = number
  nullable    = true
}

variable "autoscalling_min_size" {
  default     = 1
  description = "Minimum concurrency for auto-scaling"
  type        = number
  nullable    = true
}

variable "autoscalling_max_size" {
  default     = 5
  description = "Target concurrency for auto-scaling"
  type        = number
}

# Image registry
variable "registry_name" {
  default     = "registry"
  description = "Name of the ECR repository"
  type        = string
}

variable "registry_tag_mutability" {
  default     = "MUTABLE"
  description = "Image tag mutability for the ECR repository"
  type        = string
}

variable "registry_scan_on_push" {
  default     = true
  description = "Enable image scanning on push for the ECR repository"
  type        = bool
}

# CloudFront
variable "route53_private_zone" {
  default = false
  type    = bool
}

variable "route53_zone_domain" {
  default     = ""
  type        = string
  description = "Route53 zone domain (base domain)"
  nullable    = false
}

variable "api_domain" {
  type        = string
  description = "Domain name (Where you want to deploy the CloudFront distribution. Leave empty to deploy inside base domain)"
  nullable    = false
}

variable "cloudfront_allowed_methods" {
  default = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
  type    = list(string)
}

variable "cloudfront_cached_methods" {
  default = ["HEAD", "GET", "OPTIONS"]
  type    = list(string)
}

variable "cloudfront_default_root_object" {
  default = null
  type    = string
}

variable "cloudfront_http_version" {
  default = "http2and3"
  type    = string
}

# Response headers policy
variable "cors_allow_credentials" {
  default     = true
  description = "Allow credentials in CORS requests"
  type        = bool
}

variable "cors_allow_origins" {
  default     = []
  description = "List of allowed origins for CORS requests"
  type        = list(string)
}

variable "cors_allow_headers" {
  default     = ["Authorization", "Access-Control-Allow-Origin", "x-request-id", "x-amzn-trace-id", "x-consumer-custom-id", "Content-Type"]
  description = "List of allowed headers for CORS requests"
  type        = list(string)
}

variable "cors_allow_methods" {
  default     = ["GET", "POST", "PUT", "PATCH", "HEAD", "DELETE", "OPTIONS"]
  description = "List of allowed methods for CORS requests"
  type        = list(string)
}

variable "cors_expose_headers" {
  default     = ["Access-Control-Allow-Credentials", "Access-Control-Allow-Origin", "Access-Control-Allow-Headers"]
  description = "Max age for CORS requests in seconds"
  type        = list(string)
}

variable "cors_max_age_seconds" {
  default     = 600
  description = "Max age for CORS requests in seconds"
  type        = number
}


variable "vpc_connector_arn" {
  default     = null
  description = "ARN of the VPC connector to use for the App Runner service"
  type        = string
}
