# Lab: JFrog BOMs basics

## Goals

Practice manipulating JFrog BOMs

## Create a repository structure

in your JFrog Project, create the following repositories :

Repo type | Repo key | Environment | Comment
---|---|--- |---
LOCAL | <PROJECT_KEY>-maven-rc-local | DEV |
LOCAL | <PROJECT_KEY>-maven-release-local | PROD |
REMOTE | <PROJECT_KEY>-mavencentral-remote | DEV |
VIRTUAL | <PROJECT_KEY>-maven  | DEV | include the 3 repos above and set default deployement to  <PROJECT_KEY>-maven-rc-local

### Build Info (only from API)

> Here is the [official documentation for the Build Info](https://jfrog.com/help/r/jfrog-integrations-documentation/build-integration)

1. Generate an publish a Build Info into your project

   ```bash
      ../../demos/basics-bom/bom-publish.sh <PROJECT_KEY>-maven <PROJECT_KEY>
   ```

2. Go to the Build info section > select a version and navigate on teh different tabs

### RBv2 (from UI)

> Here is the [official documentation for the Release LifeCycle Management](https://jfrog.com/help/r/jfrog-artifactory-documentation/release-lifecycle-management)

1. Generate a Release Bundle V2 from your Build Info
2. Promote your Release Bundle V2 to the PROD environment
3. Add an ``ÀRCHIVE`` project environment and assign it to <PROJECT_KEY>-archive-maven-local
4. Promote your Release Bundle V2 to the ``ÀRCHIVE`` environment
