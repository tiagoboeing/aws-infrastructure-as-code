variable "service_name" {
  description = "Service name used for tagging"
  type        = string
  nullable    = false
}

variable "public_subnet_id_1" {
  description = "Public subnet ID 1"
  type        = string
  nullable    = false
}

variable "public_subnet_id_2" {
  description = "Public subnet ID 2"
  type        = string
  nullable    = false
}
