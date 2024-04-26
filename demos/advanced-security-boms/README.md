# Demo: Leverage JFrog BOMs continuous scanning

## Pre requisites

1. The following repositories assigned to the JFrog Project

   Repo type | Repo key | Environment | Comment
   ---|---|--- |---
   LOCAL | green-maven-dev-local | DEV |
   LOCAL | green-maven-rc-local | DEV |
   LOCAL | green-maven-release-local | PROD |
   LOCAL | green-maven-prod-local | PROD |
   REMOTE | mavencentral-remote | DEV |
   VIRTUAL | green-maven  | DEV | include the 3 repos above and set default deployement to  green-rc-maven-local

2. 1 Xray policy & watch


## Configure Build Info indexing in Xray

On the UI, go to  Xray > Indexed resources > Managed Builds
<img src="../../images/Xray-indexing-all-builds.png">

## Generate multiple Build Info in CI Pipeline

* This demo will show how to create a Build Info for an Application and its Containerized version to achiveve full traceability
* The Container Build Info can be then used to generate a Release Bundle V2

```bash
   cd ../../common/java

   MY_PROJ_KEY="green"
   MY_IMAGE="${JFROG_SAAS_DNS}/${MY_PROJ_KEY}-docker/java-app:1.0.0"
   export JFROG_CLI_BUILD_NAME=${MY_PROJ_KEY}-app JFROG_CLI_BUILD_NUMBER=1
   # export JFROG_CLI_BUILD_PROJECT=${MY_PROJ_KEY}
   
   ... 

   # build app + deploy + generate Application Build Info
   jf mvn clean package deploy

   # add complementary info to the Build Info
   # git hash, git branch
   jf rt bag 

   # environment variables
   jf rt bce
   
   # publish Application Build Info
   jf rt bp 

   echo "*****************************"
   echo "**** CONTAINERIZE APP"  
   echo "*****************************"

   ...

   echo "*****************************"
   echo "**** PUSH IMAGE TO ARTIFACTORY WITH BUILD INFO"  
   echo "*****************************"

   # init Container Build info + populate "artifact" section of the Container Build info
   jf docker push $MY_IMAGE \
      --build-name="${JFROG_CLI_BUILD_NAME}-container" \
      --build-number=${JFROG_CLI_BUILD_NUMBER}

   # add application as a dependeny of the Container Build Info
   jf rt bad "./target/*.war" "${JFROG_CLI_BUILD_NAME}-container" ${JFROG_CLI_BUILD_NUMBER}

   # publish Container Build Info
   jf rt bp "${JFROG_CLI_BUILD_NAME}-container" ${JFROG_CLI_BUILD_NUMBER}

```

## Configure RBv2 indexing in Xray

On the UI, go to  Xray > Indexed resources > V2 > Add a Release Bundle > By Pattern
<img src="../../images/Xray-indexing-all-rbv2.png">

## Generate a Release Bundle V2 in CI Pipeline

Generate a RBv2 from a Build Info.
see [Advanced BOM demo](../advanced-bom/README.md)
