variable "service" {
  default     = "terraform-cdn"
  type        = string
  description = "Service name"
}

variable "stage" {
  default     = "dev"
  type        = string
  description = "Stage (dev, test, prod)"
}

variable "create_domain" {
  default     = true
  type        = bool
  description = "Create Route53 domain"
}

variable "route53_private_zone" {
  default = false
  type    = bool
}

variable "route53_zone_domain" {
  default     = ""
  type        = string
  description = "Route53 zone domain (base domain)"
}

variable "cdn_domain" {
  default     = ""
  type        = string
  description = "Domain name (Where you want to deploy the CloudFront distribution. Leave empty to deploy inside base domain)"
}
