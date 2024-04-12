# Lab: JFrog Projects

## Goals

Automate JFrog Projects creation and configuration

## Create & configure a JFrog Project

> Here is the [official documentation for JFrog Project](https://jfrog.com/help/r/jfrog-rest-apis/projects?tocId=EdXas7XMSjSwMAunjWXA7w)

Set a stoarge quota to 1 GB and disable Project admin

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"../../demos/advanced-projects/payload/project-api-def.json" \
$JFROG_SAAS_URL/access/api/v1/projects
```

## Provision repositories

1. [Move / Assign](https://jfrog.com/help/r/jfrog-platform-administration-documentation/step-3-add-or-assign-resources-to-projects) existing repositories to your JFrog Project using the UI and then API
2. [OPTIONAL] Create new repositories in your JFrog Project using the UI and then API

## Publish BOMs

1. Publish Build Info to a JFrog Project by setting up the **JFROG_CLI_BUILD_PROJECT** env variable with your <PROJECT_KEY> (see Lab-3)
2. [OPTIONAL] Publish RBv2

## Configure a security process

> Here are the :
>
> * [official documentation for Roles](https://jfrog.com/help/r/jfrog-rest-apis/global-roles)
> * [official documentation for Policies](https://jfrog.com/help/r/xray-rest-apis/policies-v2)
> * [official documentation for Watches](https://jfrog.com/help/r/xray-rest-apis/watches)

1. Create a new Project role named **Security Champion** role which can't create polices but can manage watches & reports
2. Create a Xray Global security policy
3. Create a Xray Project watch configured with any repositories in the Project and the above Security policy
