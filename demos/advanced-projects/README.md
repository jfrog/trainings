# Demo: JFrog Projects

## Pre requisites

None

## Create a JFrog Project using API

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"payload/project-api-def.json" \
$JFROG_SAAS_URL/access/api/v1/projects
```

## Provision repositories using API

```bash

# create new global and project environments
curl \
   -X POST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d '{"name": "RELEASE-CANDIDATE"}' \
$JFROG_SAAS_URL/access/api/v1/environments

curl \
   -X POST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d '{"name": "blueteam-RELEASE-CANDIDATE"}' \
$JFROG_SAAS_URL/access/api/v1/projects/blueteam/environments

# create new repositories in your JFrog Project
# be careful the repository key has to be part of the URL and match the "key" in the JSON payload !
curl \
   -X PUT \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d "@payload/repo-api-def.json" \
$JFROG_SAAS_URL/artifactory/api/repositories/blueteam-maven-archive-local

# assign existing repositories to your JFrog Project
curl \
   -XPUT \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
"$JFROG_SAAS_URL/access/api/v1/projects/_/attach/repositories/<REPO_KEY>/blueteam?force=true"
```

## Publish JFrog BOMs to Project

### Build info

export the ```JFROG_CLI_BUILD_PROJECT=<PROJECT_KEY>``` environment variable

### RBv2

```bash
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: rbv2_no_pass" \
    -d @"../../demos/advanced-bom/payload/rb_from_files2.json" \
"$JFROG_SAAS_URL/lifecycle/api/v2/release_bundle?project-key=blueteam"
```

## Implement a global role for Security Champions

A Security Champion role can :

+ create / update / delete Project watches
+ create / delete Project reposts
+ ignore violations in watches

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"payload/role-api-def.json" \
$JFROG_SAAS_URL/access/api/v1/roles
```

Create JFrog Xray Policies and Watches

```bash
# add a query param "?projectKey=<PROJECT_KEY>" to create a project policy 
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"../basics-security-xray/payload/policy-api-def.json" \
"$JFROG_SAAS_URL/xray/api/v2/policies?projectKey=blueteam"

# add a query param "?projectKey=<PROJECT_KEY>" to create a project watch
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"../basics-security-xray/payload/watch-api-def.json" \
"$JFROG_SAAS_URL/xray/api/v2/watches?projectKey=blueteam"
```

## Switch to JFrog Projects

mono repo (team folder) to JFrog Project

apply props to recognize artifacts
