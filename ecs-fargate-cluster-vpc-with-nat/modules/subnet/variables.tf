variable "region" {
  description = "AWS region"
  type        = string
  nullable    = false
}

variable "service_name" {
  description = "Service name used for tagging"
  type        = string
  nullable    = false
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  nullable    = false
}
