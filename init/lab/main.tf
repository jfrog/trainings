terraform {
  required_providers {
    artifactory = {
      source  = "registry.terraform.io/jfrog/artifactory"
      version = "9.7.0"
    }
    xray = {
      source  = "jfrog/xray"
      version = "2.1.0"
    }
    project = {
      source  = "jfrog/project"
      version = "1.3.4"
    }
  }
}

variable "artifactory_url" {
  type    = string
  default = null
}

variable "artifactory_access_token" {
  type    = string
  default = null
}

# Configure the Artifactory provider
provider "artifactory" {
  url          = var.artifactory_url
  access_token = var.artifactory_access_token
}

# Configure the Xray provider
provider "xray" {
  url          = var.artifactory_url
  access_token = var.artifactory_access_token
}

# Configure the JFrog Projects provider
provider "project" {
  url          = var.artifactory_url
  access_token = var.artifactory_access_token
}

# Repositories

resource artifactory_local_generic_repository generic_local {
  key = "generic-lab-local"
}

resource artifactory_local_maven_repository maven_bom_lab_dev {
  key                  = "maven-bom-lab-dev-local"
  project_environments = ["DEV"]
}

resource artifactory_local_maven_repository maven_bom_lab_prod {
  key                  = "maven-bom-lab-prod-local"
  project_environments = ["PROD"]
}

# For the "Switch to Projects" lab

resource "artifactory_local_maven_repository" "maven_repositories" {
  for_each = toset([
    "team1-maven-dev-local",
    "team1-maven-prod-local",
    "team2-maven-dev-local",
    "team2-maven-prod-local",
  ])
  key = each.key
}

resource "artifactory_local_docker_v2_repository" "docker_repositories" {
  for_each = toset([
    "team1-docker-dev-local",
    "team1-docker-prod-local"
  ])
  key = each.key
}

resource "artifactory_remote_maven_repository" "maven_central" {
  key = "team1-maven-central-remote"
  url = "https://jcenter.bintray.com"
}

resource "artifactory_virtual_maven_repository" "team1_maven_virtual" {
  key          = "team1-maven-virtual"
  repositories = [
    artifactory_local_maven_repository.maven_repositories["team1-maven-dev-local"].key,
    # Ensure TF module self-sufficiency
    artifactory_remote_maven_repository.maven_central.key
  ]
}

resource "artifactory_virtual_maven_repository" "team2_maven_virtual" {
  key          = "team2-maven-virtual"
  repositories = [
    artifactory_local_maven_repository.maven_repositories["team2-maven-dev-local"].key,
    # Ensure TF module self-sufficiency
    artifactory_remote_maven_repository.maven_central.key
  ]
}

# Team 1 users / groups / permissions

resource "artifactory_user" "team1_users" {
  for_each = {
    team1dev1   = artifactory_group.team1_devs
    team1dev2   = artifactory_group.team1_devs
    team1releng = artifactory_group.team1_relengs
    team1admin  = artifactory_group.team1_admins
  }
  name     = each.key
  email    = "labs-${each.key}@jfrog.io"
  password = "Labuser1!"
  groups   = [each.value.name]
}

resource "artifactory_group" "team1" {
  name = "team1"
}

resource "artifactory_group" "team1_devs" {
  name = "team1-developers"
}

resource "artifactory_group" "team1_relengs" {
  name = "team1-release-engineers"
}

resource "artifactory_group" "team1_admins" {
  name = "team1-admins"
}

resource "artifactory_permission_target" "team1_dev_access" {
  name = "team1-development-access"
  repo {
    repositories = [
      artifactory_local_maven_repository.maven_repositories["team1-maven-dev-local"].key,
      artifactory_local_docker_v2_repository.docker_repositories["team1-docker-dev-local"].key
    ]
    actions {
      groups {
        name        = artifactory_group.team1_devs.name
        permissions = [
          "read", "write", "annotate", "delete"
        ]
      }
      groups {
        name        = artifactory_group.team1_relengs.name
        permissions = [
          "read", "write", "annotate", "delete"
        ]
      }
    }
  }
  build {
    repositories     = ["artifactory-build-info"]
    includes_pattern = ["**"]
    actions {
      groups {
        name        = artifactory_group.team1_devs.name
        permissions = ["read", "write", "annotate"]
      }
      groups {
        name        = artifactory_group.team1_relengs.name
        permissions = ["read", "write", "annotate"]
      }
    }
  }
}

resource "artifactory_permission_target" "team1_prod_access" {
  name = "team1-prod-access"
  repo {
    repositories = [
      artifactory_local_maven_repository.maven_repositories["team1-maven-prod-local"].key,
      artifactory_local_docker_v2_repository.docker_repositories["team1-docker-prod-local"].key
    ]
    actions {
      groups {
        name        = artifactory_group.team1_relengs.name
        permissions = [
          "read", "write", "annotate"
        ]
      }
    }
  }
  release_bundle {
    repositories = [
      "release-bundles",
      "release-bundles-v2"
    ]
    includes_pattern = ["team1-*"]
    actions {
      groups {
        name        = artifactory_group.team1_relengs.name
        permissions = [
          "read", "write", "annotate", "distribute"
        ]
      }
    }
  }
}

# Team 2 users / groups

resource "artifactory_user" "team2_users" {
  for_each = {
    team2dev1   = artifactory_group.team2_devs
    team2releng = artifactory_group.team2_relengs
    team2admin  = artifactory_group.team2_admins
  }
  name     = each.key
  email    = "labs-${each.key}@jfrog.io"
  password = "Labuser1!"
  groups   = [each.value.name]
}

resource "artifactory_group" "team2" {
  name = "team2"
}

resource "artifactory_group" "team2_devs" {
  name = "team2-developers"
}

resource "artifactory_group" "team2_relengs" {
  name = "team2-release-engineers"
}

resource "artifactory_group" "team2_admins" {
  name = "team2-admins"
}

resource "artifactory_permission_target" "team2_dev_access" {
  name = "team2-development-access"
  repo {
    repositories = [
      artifactory_local_maven_repository.maven_repositories["team2-maven-dev-local"].key
    ]
    actions {
      groups {
        name        = artifactory_group.team2_devs.name
        permissions = [
          "read", "write", "annotate", "delete"
        ]
      }
      groups {
        name        = artifactory_group.team2_relengs.name
        permissions = [
          "read", "write", "annotate", "delete"
        ]
      }
    }
  }
  build {
    repositories     = ["artifactory-build-info"]
    includes_pattern = ["**"]
    actions {
      groups {
        name        = artifactory_group.team2_devs.name
        permissions = ["read", "write", "annotate"]
      }
      groups {
        name        = artifactory_group.team2_relengs.name
        permissions = ["read", "write", "annotate"]
      }
    }
  }
}

resource "artifactory_permission_target" "team2_prod_access" {
  name = "team2-prod-access"
  repo {
    repositories = [
      artifactory_local_maven_repository.maven_repositories["team2-maven-prod-local"].key
    ]
    actions {
      groups {
        name        = artifactory_group.team2_relengs.name
        permissions = [
          "read", "write", "annotate"
        ]
      }
    }
  }
  release_bundle {
    repositories = [
      "release-bundles",
      "release-bundles-v2"
    ]
    includes_pattern = ["team2-*"]
    actions {
      groups {
        name        = artifactory_group.team2_relengs.name
        permissions = [
          "read", "write", "annotate", "distribute"
        ]
      }
    }
  }
}

# General permissions

resource "artifactory_permission_target" "any_remote" {
  name = "global-remote"
  repo {
    repositories = [
      "ANY REMOTE"
    ]
    actions {
      groups {
        name        = artifactory_group.team1.name
        permissions = ["read", "write", "annotate"]
      }
      groups {
        name        = artifactory_group.team2.name
        permissions = ["read", "write", "annotate"]
      }
    }
  }
}

# Others

resource artifactory_keypair main_signing {
  alias       = "main"
  pair_name   = "main"
  pair_type   = "GPG"
  private_key = file("../resources/private.asc")
  public_key  = file("../resources/public.asc")
}
