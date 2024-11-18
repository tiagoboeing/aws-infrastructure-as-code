variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  nullable    = false
}

variable "service_name" {
  description = "Service name used for tagging"
  type        = string
  nullable    = false
}
