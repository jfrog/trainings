# Lab: Xray basics

## Goal

Setup a security process to continuously scan your artifacts

## Pre requisites

Repo type | Repo key | Environment | Comment
---|---|--- |---
REMOTE | mavencentral-remote | DEV | enable Xray
VIRTUAL | <PROJECT_KEY>-maven  | DEV | include the above repo
REMOTE | npmjs-remote | DEV | enable Xray
VIRTUAL | <PROJECT_KEY>-npm  | DEV | include the above repo
LOCAL | green-docker-local  | DEV | 

## Index Artifactory resources via UI

> Here is the [official documentation for Xray indexing](https://jfrog.com/help/r/jfrog-security-documentation/add-or-remove-resources-from-indexing)

1. Go to Xray > Indexed resources > repositories
2. Verify **mavencentral-remote** and **npmjs-remote** are indexed
3. Add a docker repository

## Create JFrog Xray Policies and Watches via UI

> Here is the official documentation for creating
>
> * [a Xray policy](https://jfrog.com/help/r/jfrog-security-documentation/create-an-xray-policy)
> * [a Xray watch](https://jfrog.com/help/r/jfrog-security-documentation/create-a-watch)

1. Create security policy with minimum severity to High
2. Create a license policy and blacklist APACHE-2
3. Create a watch on all repositories and reference the 2 created policies

### OPTIONAL : Create JFrog Xray Policies and Watches via API

> Here is the official Rest API documentation for
>
> * [Policies](https://jfrog.com/help/r/xray-rest-apis/policies-v2)
> * [Watches](https://jfrog.com/help/r/xray-rest-apis/watches)

Examples

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"../../demos/basics-security-xray/payload/policy-api-def.json" \
$JFROG_SAAS_URL/xray/api/v2/policies

curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"../../demos/basics-security-xray/payload/watch-api-def-docker.json" \
$JFROG_SAAS_URL/xray/api/v2/watches
```

## Scan artifacts

1. Upload a docker image to the docker repository(you can build Dockerfile under /common/js)
2. Enable block download on dependencies

## View scan results on the UI

1. Go to Xray > Scan List
2. Browse the different sections on a artifacts with vulnerabilities
3. Browse the violation view and ignore violations
