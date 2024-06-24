# Lab: Xray basics

## Goal

Setup a security process to continuously scan your artifacts

## Pre requisites

Repo type | Repo key | Environment | Comment
---|---|--- |---
REMOTE | <YOUR_NAME>-npmjs-remote | DEV | enable Xray
VIRTUAL | <PROJECT_KEY>-npm  | DEV | include the above repo
LOCAL | <YOUR_NAME>-docker-local  | DEV | 

## Index Artifactory resources via UI

> Here is the [official documentation for Xray indexing](https://jfrog.com/help/r/jfrog-security-documentation/add-or-remove-resources-from-indexing)

1. Go to Xray > Indexed resources > repositories
2. Verify **<YOUR_NAME>-mavencentral-remote** and **<YOUR_NAME>-npmjs-remote** are indexed
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
# **UPDATE** the name within policy-api-def.json to prefix <YOUR_NAME>
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"policy-api-def.json" \
$JFROG_SAAS_URL/xray/api/v2/policies

# **PLEASE UPDATE** within watch-api-def-docker.json **YOUR DATA**
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"watch-api-def-docker.json" \
$JFROG_SAAS_URL/xray/api/v2/watches
```

## Scan artifacts

1. Go to `common/js` folder
2. Build the Dockerfile
3. Use Set Up A Docker Client for your <YOUR_NAME>-docker-local --> Here is the [official documentation](https://jfrog.com/help/r/jfrog-artifactory-documentation/use-kubernetes-with-artifactory-cloud)
4. Upload a docker image to your docker repository

## View scan results on the UI

1. Go to Xray > Scan List
2. Browse the different sections on a artifacts with vulnerabilities
3. Browse the violation view and ignore violations
