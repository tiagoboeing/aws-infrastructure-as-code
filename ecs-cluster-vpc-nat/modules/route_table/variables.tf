variable "service_name" {
  description = "The name of the service"
  type        = string
  nullable    = false
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  nullable    = false
}

variable "igw_id" {
  description = "The ID of the internet gateway"
  type        = string
  nullable    = false
}

variable "az_1" {
  description = "Name of the Availability Zone 1"
  type        = string
  nullable    = false
}

variable "az_2" {
  description = "Name of the Availability Zone 2"
  type        = string
  nullable    = false
}

variable "subnet_public_az_1" {
  description = "The ID of the public subnet in AZ 1"
  type        = string
  nullable    = false
}

variable "subnet_public_az_2" {
  description = "The ID of the public subnet in AZ 2"
  type        = string
  nullable    = false
}

variable "subnet_private_az_1" {
  description = "The ID of the private subnet in AZ 1"
  type        = string
  nullable    = false
}

variable "subnet_private_az_2" {
  description = "The ID of the private subnet in AZ 2"
  type        = string
  nullable    = false
}

variable "nat_gw_id_1" {
  description = "The ID of the first NAT gateway (AZ 1)"
  type        = string
  nullable    = false
}

variable "nat_gw_id_2" {
  description = "The ID of the first NAT gateway (AZ 2)"
  type        = string
  nullable    = false
}
