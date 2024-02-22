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

> Here is the [official documentation for Environments](https://jfrog.com/help/r/jfrog-rest-apis/environments)

1. Move / Assign existing repositories to your JFrog Project using the UI and then API
2. Create new repositories in your JFrog Project using the UI and then API

## Publish BOMs

1. Publish Build Info
2. Publish RBv2

## Configure a security process

> Here is the [official documentation for Roles](https://jfrog.com/help/r/jfrog-rest-apis/global-roles)
> Here is the [official documentation for Policies](https://jfrog.com/help/r/xray-rest-apis/policies-v2)
> Here is the [official documentation for Watches](https://jfrog.com/help/r/xray-rest-apis/watches)

1. Create a new Project role named **Security Champion** role which can't create polices but can manage watches & reports
2. Create a Xray Global security policy
3. Create a Xray Project watch configured with any repositories in the Project and the above Security policy
