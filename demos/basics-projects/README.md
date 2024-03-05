# Demo: JFrog Projects

## Pre requisites

1. 1 JFrog project with a project key = **green**
2. the following repositories assigned to the JFrog Project

    Repo type | Repo key | Environment | Comment
    ---|---|--- |---
    LOCAL | green-maven-dev-local | DEV |
    LOCAL | green-maven-rc-local | DEV |
    LOCAL | green-maven-release-local | PROD |
    LOCAL | green-maven-prod-local | PROD |
    REMOTE | mavencentral-remote | DEV |
    VIRTUAL | green-maven  | DEV | include the 3 repos above and set default deployement to  green-rc-maven-local

3. the following users assigned to the JFrog Project

    Name | Entity | Role | Comment
    ---|---|--- |---
    g_dev | Group | Developer |
    g_qa | Group | Contributor |
    deploy | Group | Viewer |
    jan | User | Project Admin |
    feb | User | Developer | Belong to g_dev group
    mar | User | Developer | Belong to g_dev group
    apr | User | Release Manager |
    may | User | Viewer |
    jun | User | Contributor | Belong to g_dev group

## JFrog Project introduction

via the UI

1. Select "Project All" and click on "Add project"
2. Specify "Project Name" and a "Project Key"
3. Click on "Create"

Explain:

+ Storage quota
+ Project Admins management

## Repository

1. Create a generic repository and assign the ```DEV``` environment
2. Upload an artifact to the repository

Explain:

+ Repository creation (prefixed with repo key)
+ Repository assignment
+ Repository sharing

## RBAC

1. Onboard a user with a Project Admin role
2. Show Global and Project enviroments
3. Show Global and Project Roles
4. Create a new Project role using a new Project environment

Explain:

+ Global and Project Environment + usage (relationships to roles & repositories + RBv2 promotion)
+ Create Global and Project Roles
