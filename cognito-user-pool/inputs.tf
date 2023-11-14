variable "stage" {
  default     = "dev"
  type        = string
  description = "Stage (dev, test, prod)"
}

variable "pool_name" {
  type        = string
  description = "The name of the user pool"
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
}

variable "google_credentials" {
  description = "Linkedin OIDC settings"
  type        = map(string)
}
