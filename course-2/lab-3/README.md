# Lab: JFrog BOMs

## Goals

Practice manipulating JFrog BOMs

## Create build info (only from API)

> Here is the [official documentation for the JFrog CLI](https://docs.jfrog-applications.jfrog.io/)

> Here is the [official documentation for generating Build Info per package manager](https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/cli-for-jfrog-artifactory#package-managers-integration)

## Pre requisites(most of it had been created in lab 2)

Repo type | Repo key | Environment | Comment
---|---|--- |---
LOCAL | USERNAME-maven-dev-local | DEV |
LOCAL | USERNAME-maven-rc-local | DEV |
LOCAL | USERNAME-maven-release-local | PROD |
LOCAL | USERNAME-maven-prod-local | PROD |
REMOTE | USERNAME-mavencentral-remote | DEV |
VIRTUAL | USERNAME-maven  | DEV | include the 3 repos above and set default deployement to  USERNAME-rc-maven-local

1. Navigate to [shared Java project directory](../../common/java).
2. Create build configuration:

   ```bash
   export MY_PROJ_KEY=<USERNAME> # 'export' command is for linux, for windows use 'set' command
   jf mvnc \
      --repo-deploy-releases   ${MY_PROJ_KEY}-maven \
      --repo-deploy-snapshots  ${MY_PROJ_KEY}-maven \
      --repo-resolve-releases  ${MY_PROJ_KEY}-maven \
      --repo-resolve-snapshots ${MY_PROJ_KEY}-maven

   cat .jfrog/projects/maven.yaml
   ```

3. Build & deploy:

   ```bash
   export JFROG_CLI_BUILD_NAME=${MY_PROJ_KEY}-app  JFROG_CLI_BUILD_NUMBER=1
   // export JFROG_CLI_BUILD_PROJECT=${MY_PROJ_KEY} # this is for jfrog projects, we're not using projects in this lab
   jf mvn clean package deploy 
   ```

4. Push the build info to Artifactory:

   ```bash
   jf rt bce && jf rt bag && jf rt bp
   ```

Then, navigate to "Artifactory" -> "Builds", and show ```<PROJECT_KEY>-app``` and its build (```1```).
Show the Build info repository on the UI

## RBv2 management from the UI

### Creation

Show the existing Release Bundle repository on the UI

1. From the build's screen in Artifactory, click on a build name
2. Hover over a version and click on the 3 dots on the far right
3. Click on "Create Release Bundle".

> You can also create a Release Bundle at the Build Version level

* Release Bundle Name: `<PROJECT_KEY>-release`
* Release Bundle Version: `1.0`
* Signing Key: `thekey`

Click "Next", then "Create".

## Promotion

> The order of environment can be changed on the UI (Plaform configuration > Environments)

After navigating to the RBv2's screen, click "Promote".

* For Signing Key, select `thekey`.
* For Target Environment, select `PROD`.

Click "Next", ensure that the "Target Repositories" for Maven artifacts is set properly, and click "Promote".

## RBv2 management from the API

> Here is the [official documentation for RBv2 API](https://jfrog.com/help/r/jfrog-rest-apis/release-lifecycle-management)

## Creation via the API (Go to course-2/lab-3 folder)

1. Create a RBv2 from AQL using rb_from_aql_ok.json - UPDATE release_bundle_name, and repo

```bash
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
    -d @"rb_from_aql_ok.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/release_bundle 
```

## [OPTIONAL] Promotion via the API

Perform a 1st promotion of your Release Bundle V2

Update included_repository_keys within rb_promotion.json

```bash
rb_name="rbv2_from_aql" # in here put the value from release_bundle_name within rb_from_aql_ok.json
rb_version="1.0.0" # in here put the value from release_bundle_version within rb_from_aql_ok.json
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
    -d @"rb_promotion.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/promotion/records/$rb_name/$rb_version 
```

## [OPTIONAL] Promotion via the JFrog CLI

Perform a 2nd promotion of your Release Bundle V2

```bash
jf rbp  --signing-key="thekey" $rb_name $rb_version PROD
## NOTE - save the created_millis value for later
```

## [OPTIONAL] Deletion promotion via the API

> No deletion via the JFrog CLI

```bash
# you have to specify the creation time in ms, use the Get RBv2 promotion to get that info
rb_creation_time="1724221096292"
curl \
    -XDELETE \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
"$JFROG_SAAS_URL/lifecycle/api/v2/promotion/records/$rb_name/$rb_version/$rb_creation_time?async=false" 
```
