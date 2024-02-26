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

## Index Artifactory resources via UI

1. Go to Xray > Indexed resources > repositories
2. Verify **mavencentral-remote** and **npmjs-remote** are indexed
3. Add a docker repository

## Create JFrog Xray Policies and Watches via UI

1. Create security policy with minimum severity to High
2. Create a license policy and blacklist APACHE-2
3. Create a watch on all repositories and reference the 2 created policies

### OPTIONAL : Create JFrog Xray Policies and Watches via API

> Here is the [official documentation for Policies](https://jfrog.com/help/r/xray-rest-apis/policies-v2)
> Here is the [official documentation for Watches](https://jfrog.com/help/r/xray-rest-apis/watches)

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
   -d @"../../demos/basics-security-xray/payload/watch-api-def.json" \
$JFROG_SAAS_URL/xray/api/v2/watches
```

## Scan artifacts

1. Upload a docker image to the docker repository
2. Enable block download on dependencies

## View scan results on the UI

1. Go to Xray > Scan List
2. Browse the different sections on a artifacts with vulnerabilities
3. Browse the violation view and ignore violations
