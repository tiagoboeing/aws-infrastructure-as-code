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