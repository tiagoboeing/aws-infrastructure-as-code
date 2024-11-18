variable "service_name" {
  description = "Service name used for tagging"
  type        = string
  nullable    = false
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
  nullable    = false
}

variable "alb_security_group_id" {
  description = "ALB security group ID (traffic from internet to ALB)"
  type        = string
  nullable    = false
}
