variable "stage" {
  default     = "dev"
  type        = string
  description = "Stage (dev, test, prod)"
}

variable "pool_name" {
  type        = string
  description = "The name of the user pool"
}

variable "route53_private_zone" {
  default = false
  type    = bool
}

variable "domain" {
  description = "Custom domain name to use on the user pool"
  type        = string
}

variable "logout_urls" {
  type        = list(string)
  description = "List of allowed logout URLs"
  default     = []
}

variable "callback_urls" {
  type        = list(string)
  description = "List of allowed callback URLs"
  default     = []
}

# Identity provider settings
variable "linkedin_credentials" {
  description = "Linkedin OIDC settings"
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "google_credentials" {
  description = "Google OAuth settings"
  type        = map(string)
  default     = {}
  sensitive   = true
}

# Custom domain
variable "route53_zone_domain" {
  default     = ""
  type        = string
  description = "Route53 zone domain (base domain)"
}

# Groups
variable "user_groups" {
  type        = list(map(string))
  description = "List of user groups"
  default     = [{ name = "Admins", description = "Admin users" }]
}
