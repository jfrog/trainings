## Please set the following environment variables before executing terraform code
#### JFROG_URL
#### JFROG_ACCESS_TOKEN

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
    url = "https://train17187377940.jfrog.io"
    access_token = var.main_access_token
}
provider "artifactory" {
    alias = "edge"
    url = "https://train17187377940edge.jfrog.io"
    access_token = var.edge_access_token
}