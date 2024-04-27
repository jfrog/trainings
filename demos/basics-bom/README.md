# Demo: JFrog BOM

## Pre requisites

Repo type | Repo key | Environment | Comment
---|---|--- |---
LOCAL | green-maven-dev-local | DEV |
LOCAL | green-maven-rc-local | DEV |
LOCAL | green-maven-release-local | PROD |
LOCAL | green-maven-prod-local | PROD |
REMOTE | mavencentral-remote | DEV |
VIRTUAL | green-maven  | DEV | include the 3 repos above and set default deployement to  green-rc-maven-local

## Create build info (only from API)

> Check out the ```bom-publish.sh``` script

1. Navigate to [shared Java project directory](../../common/java).
2. Create build configuration:

   ```bash
   export JFROG_CLI_BUILD_NAME=green-app JFROG_CLI_BUILD_NUMBER=1
   
   jf mvnc \
      --repo-deploy-releases green-maven \
      --repo-deploy-snapshots green-maven \
      --repo-resolve-releases green-maven \
      --repo-resolve-snapshots green-maven
   
   jf mvn clean package deploy 

   jf rt bce && jf rt bag && jf rt bp
   ```

Then, navigate to "Artifactory" -> "Builds", and show `green-app` and its build (`1`).
Show the Build info repository on the UI

## Create a RBv2 from the UI

Show the existing Release Bundle repository on the UI

1. From the build's screen in Artifactory, click on a build name
2. Hover over a version and click on the 3 dots on the far right
3. Click on "Create Release Bundle".

> You can also create a Release Bundle at the Build Version level

* Release Bundle Name: `green-release`
* Release Bundle Version: `1.0`
* Signing Key: `MYKEY - GPG`
* Ensure that "Include dependencies" is *not* selected

Click "Next", then "Create".

## Promote RBv2

> The order of environment can be changed on the UI (Plaform configuration > Environments)

After navigating to the RBv2's screen, click "Promote".

* For Signing Key, select `main`.
* For Target Environment, select `RELEASE`.

Click "Next", ensure that the "Target Repositories" for Maven artifacts is set properly, and click "Promote".
