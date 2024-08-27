## Please set the following values within secret.auto.tfvars
#### main_url
#### main_access_token


terraform {
  required_providers {
    artifactory = {
      source  = "registry.terraform.io/jfrog/artifactory"
      version = "10.6.2"
    }
  }
}

# Configure the Artifactory provider
provider "artifactory" {
    url = var.main_url
}