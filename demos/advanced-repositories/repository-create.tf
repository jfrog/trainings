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

variable "artifactory_local_maven_repository" {
  type = string
}

# Configure the Artifactory provider
provider "artifactory" {
  url           = var.artifactory_url
}

# Create a new repository
resource "artifactory_local_maven_repository" "maven_repository" {
  key             = var.artifactory_local_maven_repository
  description     = "Maven repository created through Terraform"
}
