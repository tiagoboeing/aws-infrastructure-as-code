variable "github_credentials" {
  description = "GitHub OAuth settings"
  type        = map(string)
  default     = {}
}

variable "pool_name" {
  description = "Cognito user pool name"
  type        = string
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
  default     = "cognito-github-proxy"
}

variable "stage" {
  description = "Deployment stage"
  type        = string
  default     = "dev"
}