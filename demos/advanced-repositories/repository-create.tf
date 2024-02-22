terraform {
  required_providers {
    artifactory = {
      source  = "registry.terraform.io/jfrog/artifactory"
      version = "9.7.0"
    }
  }
}

variable "artifactory_url" {
  type = string
}

variable "artifactory_access_token" {
  type = string
}

# Configure the Artifactory provider
provider "artifactory" {
  url           = var.artifactory_url
  access_token  = var.artifactory_access_token
}

# Create a new repository
resource "artifactory_local_maven_repository" "maven_repository" {
  key             = "bleuteam-generic-release-local"
  description     = "Maven repository created through Terraform"
}
