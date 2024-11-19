variable "region" {
  description = "AWS region"
  type        = string
}

variable "service_name" {
  description = "Service name"
  type        = string
  nullable    = false
}
