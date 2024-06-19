variable "users" {
  description = "A map of user names to emails"
  type        = map(string)
}

variable "main_url" {
    type = string
    description = "URL for main artifactory site"
}

variable "main_access_token" {
    type = string
    description = "Access token for main artifactory site"
    sensitive = true
}

variable "edge_url" {
    type = string
    description = "URL for edge artifactory site"
}

variable "edge_access_token" {
    type = string
    description = "Access token for edge artifactory site"
    sensitive = true
}