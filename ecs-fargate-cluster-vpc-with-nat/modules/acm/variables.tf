variable "region" {
  description = "AWS region"
  type        = string
}

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
