variable "user_count" {
  description = "The number of users to create"
  type        = number
  default     = 3
}

variable "user_password" {
    type = string
    description = "User password to login artifactory"
    sensitive = true
}

variable "main_url" {
    type = string
    description = "URL for main artifactory site"
}