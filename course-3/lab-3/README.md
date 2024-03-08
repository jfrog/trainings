# Lab: Federated repository

## Goals

Enable federated repositories

## Prerequisits

In this this we assume two JDP are already registered

## Create a federated repo from the UI

1. Create a federated repository  
Name it `demo-maven-federated`
2. Go in the federation Section
3. Select `+ Add Repository` and select The target
3. Select `Create new "demo-maven-federated"`
4. Press `Done` then `Create Federated Repo`

## Create a federated repo with CLI

1. Create a federated repository  
**To create a repo with the jfrog cli it is mandatory to use a template**
   - Create a file named `template.json` with the following content
      ```shell
      {
      "description": "Repo created during the course number 3",
      "key": "demo-maven-federated-cli",
      "packageType": "maven",
      "rclass": "federated"
      }
      ```

   - Create the repository
      ```shell
      jf rt repo-create template.json
      ```
      > It is not possible to add federated members with the jfrog cli

            jf rt curl -X POST \
               -H "Content-Type: application/json" \
               -d '{
                     "members" : [ {
                     "url" : "https://<SOURCE-ARTI>.jfrog.io/artifactory/demo-maven-federated-cli",
                     "enabled" : true
                     }, {
                     "url" : "https://<TARGET-ARTI>.jfrog.io/artifactory/demo-maven-federated-cli",
                     "enabled" : true
                     } ]
               }' /api/repositories/demo-maven-federated-cli

## Monitoring

Platform Configurations > Platform Monitoring > Federation Status
