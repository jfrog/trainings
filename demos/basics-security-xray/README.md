# Demo: Xray Basics

## Pre requisites

1. 1 JFrog project with a project key = **green**
2. the following repositories assigned to the JFrog Project

    Repo type | Repo key | Environment | Comment
    ---|---|--- |---
    REMOTE | mavencentral-remote | DEV |
    REMOTE | dockerhub-remote | DEV |
    REMOTE | npmjs-remote | DEV |
    LOCAL | green-maven-dev-local | DEV |
    LOCAL | green-docker-local | DEV |

## UI : JFrog Xray Policies and Watches

Go to Xray > Watches & Policies

## API : Create JFrog Xray Policies and Watches

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"payload/policy-api-def.json" \
$JFROG_SAAS_URL/xray/api/v2/policies

##TO FIX:  This watch target "any repo" which does not calculate, we need to target specific docker repository are ask JFROG to fix the bug
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"payload/watch-api-def.json" \
$JFROG_SAAS_URL/xray/api/v2/watches
```

## UI : Scan artifacts

Upload docker image (to be reused for JAS) - a Dockerfile is found within the common/js
Show block download on dependencies

## UI : View scan results

Go to Xray > Scan List
Show :

* security issues on different package types
* violations
Show how to ignore violations (create an ignore rules) + deleting an ignore rule

JFrog Research Request
