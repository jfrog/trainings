#/bin/bash

 cd ../../common/java

MY_PROJ_KEY=""
MY_IMAGE="${JFROG_SAAS_DNS}/${MY_PROJ_KEY}-docker/java-app:1.0.0"
export JFROG_CLI_BUILD_NAME=${MY_PROJ_KEY}-app \
        JFROG_CLI_BUILD_NUMBER=1 \
        JFROG_CLI_BUILD_URL="https://myCI.com"
# export JFROG_CLI_BUILD_PROJECT=${MY_PROJ_KEY}

echo "*****************************"
echo "**** CONFIG JFROG CLI"  
echo "*****************************"

jf mvnc \
    --repo-deploy-releases   ${MY_PROJ_KEY}-maven \
    --repo-deploy-snapshots  ${MY_PROJ_KEY}-maven \
    --repo-resolve-releases  ${MY_PROJ_KEY}-maven \
    --repo-resolve-snapshots ${MY_PROJ_KEY}-maven

# result of the mvnc instruction
#  cat .jfrog/projects/maven.yaml

echo "*****************************"
echo "**** SCAN DEPENDENCIES"  
echo "*****************************"

# scan dependencies before the build
jf audit --watches CI --fail=false

echo "*****************************"
echo "**** BUILD APP"  
echo "*****************************"

# build app + deploy + generate Application Build Info
jf mvn clean package deploy

# publish Application Build Info
jf bp 

echo "*****************************"
echo "**** CONTAINERIZE APP"  
echo "*****************************"

# containerize app
docker build \
    -t $MY_IMAGE \
    --build-arg REGISTRY=${JFROG_SAAS_DNS} \
    --build-arg DOCKER_REPO=${MY_PROJ_KEY}-docker \
.

echo "*****************************"
echo "**** SCAN CONTAINER IMAGE"  
echo "*****************************"

# scan the layers of the base image
jf docker scan $MY_IMAGE --fail=false

echo "*****************************"
echo "**** PUSH IMAGE TO ARTIFACTORY WITH BUILD INFO"  
echo "*****************************"

jf docker push $MY_IMAGE --build-name="${JFROG_CLI_BUILD_NAME}-container" --build-number=${JFROG_CLI_BUILD_NUMBER}

# add application as a dependeny of the Container Build Info
jf bad "./target/*.war" "${JFROG_CLI_BUILD_NAME}-container" ${JFROG_CLI_BUILD_NUMBER}

# publish Container Build Info
jf bp "${JFROG_CLI_BUILD_NAME}-container" ${JFROG_CLI_BUILD_NUMBER}
