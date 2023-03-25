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

variable "cloudfront_allowed_methods" {
  default = ["GET", "HEAD", "OPTIONS"]
  type    = list(string)
}

variable "cloudfront_cached_methods" {
  default = ["GET", "HEAD", "OPTIONS"]
  type    = list(string)
}

variable "cloudfront_default_root_object" {
  default = "index.html"
  type    = string
}

variable "cloudfront_http_version" {
  default = "http2"
  type    = string
}
