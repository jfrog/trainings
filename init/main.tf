terraform {
  required_providers {
    artifactory = {
      source  = "registry.terraform.io/jfrog/artifactory"
      version = "10.1.4"
    }
    xray = {
      source  = "jfrog/xray"
      version = "2.3.0"
    }
    project = {
      source  = "jfrog/project"
      version = "1.3.5"
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


##########################
# REPOSITORIES
##########################

# LOCAL docker 
# resource artifactory_local_docker_v2_repository docker_dev_local {
#   key        = "greenteam-docker-dev-local"
#   project_environments = ["DEV"]
#   xray_index = true
# }

# resource artifactory_local_docker_v2_repository docker_rc_local {
#   key        = "greenteam-docker-rc-local"
#   project_environments = ["QA"]
#   xray_index = true
# }

# resource artifactory_local_docker_v2_repository docker_rel_local {
#   key        = "greenteam-docker-release-local"
#   project_environments = ["RELEASE"]
#   xray_index = true
# }

# resource artifactory_local_docker_v2_repository docker_prod_local {
#   key        = "greenteam-docker-prod-local"
#   project_environments = ["PROD"]
#   xray_index = true
# }

# # LOCAL maven
# resource artifactory_local_maven_repository maven_dev_local {
#   key                  = "greenteam-maven-dev-local"
#   project_environments = ["DEV"]
#   xray_index           = true
# }

# resource artifactory_local_maven_repository maven_rc_local {
#   key                  = "greenteam-maven-rc-local"
#   project_environments = ["QA"]
#   xray_index           = true
# }

# resource artifactory_local_maven_repository maven_rel_local {
#   key                  = "greenteam-maven-release-local"
#   project_environments = ["RELEASE"]
#   xray_index           = true
# }

# resource artifactory_local_maven_repository maven_prod_local {
#   key                  = "greenteam-maven-prod-local"
#   project_environments = ["PROD"]
#   xray_index           = true
# }

# # LOCAL npm 
# resource artifactory_local_npm_repository npm_dev_local {
#   key                  = "greenteam-npm-dev-local"
#   project_environments = ["DEV"]
#   xray_index           = true
# }

# resource artifactory_local_npm_repository npm_rc_local {
#   key                  = "greenteam-npm-rc-local"
#   project_environments = ["QA"]
#   xray_index           = true
# }

# resource artifactory_local_npm_repository npm_rel_local {
#   key                  = "greenteam-npm-release-local"
#   project_environments = ["RELEASE"]
#   xray_index           = true
# }

# resource artifactory_local_npm_repository npm_prod_local {
#   key                  = "greenteam-npm-prod-local"
#   project_environments = ["PROD"]
#   xray_index           = true
# }


# # REMOTE
# resource artifactory_remote_docker_repository dockerhub {
#   key = "dockerhub-remote"
#   url = "https://registry-1.docker.io/"
# }

# resource artifactory_remote_maven_repository maven_central {
#   key = "maven-central-remote"
#   url = "https://repo.maven.apache.org/maven2"
# }



resource artifactory_remote_npm_repository npmjs {
  key = "npm-demo-remote"
  url = "https://registry.npmjs.org"
  xray_index = true
}


# # VIRTUAL
# resource artifactory_virtual_docker_repository docker_virtual {
#   key = "greenteam-maven"
#   default_deployment_repo = artifactory_local_docker_v2_repository.docker_rc_local.key
#   repositories = [
#     artifactory_local_docker_v2_repository.docker_dev_local.key,
#     artifactory_local_docker_v2_repository.docker_rc_local.key,
#     artifactory_local_docker_v2_repository.docker_rel_local.key,
#     artifactory_local_docker_v2_repository.docker_prod_local.key,
#     artifactory_remote_docker_repository.dockerhub.key
#   ]
# }


# resource artifactory_virtual_maven_repository maven_virtual {
#   key = "greenteam-maven"
#   default_deployment_repo = artifactory_local_maven_repository.maven_rc_local.key
#   repositories = [
#     artifactory_local_maven_repository.maven_dev_local.key,
#     artifactory_local_maven_repository.maven_rc_local.key,
#     artifactory_local_maven_repository.maven_rel_local.key,
#     artifactory_local_maven_repository.maven_prod_local.key,
#     artifactory_remote_maven_repository.maven_central.key
#   ]
# }

# resource artifactory_virtual_npm_repository npm_virtual {
#   key = "greenteam-npm"
#   default_deployment_repo = artifactory_local_npm_repository.npm_rc_local.key

#   repositories = [
#     artifactory_local_npm_repository.npm_dev_local.key,
#     artifactory_local_npm_repository.npm_rc_local.key,
#     artifactory_local_npm_repository.npm_rel_local.key,
#     artifactory_local_npm_repository.npm_prod_local.key,
#     artifactory_remote_npm_repository.npmjs.key
#   ]
# }
# Federated
# resource "artifactory_federated_docker_v2_repository" "docker-fed" {
#   key       = "ecosystem-docker-release-fed"

#   member {
#     url     = "https://tempurl.org/artifactory/ecosystem-docker-release-fed"
#     enabled = true
#   }

#   member {
#     url     = "http:s//tempurl2.org/artifactory/ecosystem-docker-release-fed"
#     enabled = true
#   }
# }

##########################
# GROUPS
##########################

resource "artifactory_group" "greenteam_devs" {
  name = "greenteam-dev"
}

resource "artifactory_group" "greenteam_tech-leads" {
  name = "greenteam-tech-lead"
}

resource "artifactory_group" "greenteam_ops" {
  name = "ops"
}

resource "artifactory_group" "devs" {
  name = "developers"
}

resource "artifactory_group" "uploaders" {
  name = "uploaders"
}

resource "artifactory_group" "deployers" {
  name = "deployers"
}

##########################
# PROJECT
##########################

resource project project {
  key          = "greenteam"
  display_name = "Green"
  admin_privileges {
    index_resources  = true
    manage_members   = true
    manage_resources = true
  }
}

##########################
# XRAY
##########################

resource "xray_security_policy" "ide_policy" {
  name        = "IDE"
  description = "to configure dev IDE"
  type        = "security"
  # project_key = "testproj"

  rule {
    name     = "important"
    priority = 1

    criteria {
      min_severity          = "High"
      fix_version_dependant = true
    }

    actions {
      webhooks                           = []
      mails                              = []
      block_release_bundle_distribution  = false
      fail_build                         = false
      notify_watch_recipients            = false
      notify_deployer                    = false
      create_ticket_enabled              = false // set to true only if Jira integration is enabled
      //build_failure_grace_period_in_days = 5     // use only if fail_build is enabled

      block_download {
        unscanned = false
        active    = false
      }
    }
  }
}

resource "xray_watch" "ide_watch" {
  name        = "IDE"
  description = "to configure dev IDE"
  active      = true
  assigned_policy {
    name = xray_security_policy.ide_policy.name
    type = xray_security_policy.ide_policy.type
  }

  // it could be anything as this watch will only be used by the IDE
  // if a report had to be generated out of this watch, then include all the remote repos
  watch_resource {
    type       = "repository"
    bin_mgr_id = "default"
    name       = artifactory_remote_npm_repository.npmjs.key
    repo_type  = "remote"

    # filter {
    #   type  = "regex"
    #   value = ".*"
    # }  
  }
}

# Others

# resource artifactory_keypair main_signing {
#   alias       = "main"
#   pair_name   = "main"
#   pair_type   = "GPG"
#   private_key = file("../resources/private.asc")
#   public_key  = file("../resources/public.asc")
# }
