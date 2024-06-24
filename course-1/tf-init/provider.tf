## Please set the following values within secret.auto.tfvars
#### main_url, edge_url
#### main_access_token, edge_access_token


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
    access_token = var.main_access_token
}
provider "artifactory" {
    alias = "edge"
    url = var.edge_url
    access_token = var.edge_access_token
}