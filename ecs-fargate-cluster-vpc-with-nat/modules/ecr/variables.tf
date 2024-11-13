variable "region" {
  description = "AWS region"
  type        = string
}

variable "repository_name" {
  description = "Repository name (eg.: namespace/repo-name)"
  type        = string
  nullable    = false
}

variable "image_scanning" {
  description = "Enable image scanning"
  type        = bool
  default     = false
}

variable "image_tag_mutability" {
  description = "Image tag mutability (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
}
