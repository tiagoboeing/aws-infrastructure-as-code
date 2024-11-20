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
  nullable    = false
}

# ECR
variable "ecr_repository_name" {
  default     = "namespace/repo-name"
  description = "Repository name (eg.: namespace/repo-name)"
  type        = string
  nullable    = false
}

# Custom domain
variable "domain" {
  default     = ""
  description = "Domain where cluster will be provisioned (e.g. example.com)"
  type        = string
}
variable "route53_base_domain" {
  default     = ""
  type        = string
  description = "Route53 hosted zone domain (use the base domain)"
}

variable "route53_private_zone" {
  default = false
  type    = bool
}

# Subnets
variable "subnet_az_1" {
  description = "Availability Zone 1"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_az_2" {
  description = "Availability Zone 2"
  type        = string
  default     = "us-east-1b"
}
