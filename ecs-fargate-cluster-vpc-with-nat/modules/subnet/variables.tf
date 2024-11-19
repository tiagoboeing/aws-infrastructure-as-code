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


variable "az_1" {
  description = "Availability Zone 1"
  type        = string
  nullable    = false
}

variable "az_2" {
  description = "Availability Zone 2"
  type        = string
  nullable    = false
}
