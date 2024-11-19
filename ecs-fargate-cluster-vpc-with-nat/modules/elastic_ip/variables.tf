variable "service_name" {
  description = "Service name used for tagging"
  type        = string
  nullable    = false
}

variable "network_interface_az1_id" {
  description = "ID of the network interface in AZ 1"
  type        = string
  nullable    = false
}

variable "network_interface_az2_id" {
  description = "ID of the network interface in AZ 2"
  type        = string
  nullable    = false
}
