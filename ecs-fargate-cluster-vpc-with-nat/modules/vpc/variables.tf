variable "region" {
  description = "AWS region"
  type        = string
}

variable "service_name" {
  description = "Service name used for tagging"
  type        = string
  nullable    = false
}
