variable "domain" {
  description = "Domain name to request a certificate (e.g. example.com)"
  type        = string
  nullable    = true
}

variable "route53_base_domain" {
  description = "Route53 base domain"
  type        = string
}

variable "route53_private_zone" {
  description = "Route53 private zone"
  type        = bool
}

variable "service_name" {
  description = "Service name"
  type        = string
  nullable    = false
}
