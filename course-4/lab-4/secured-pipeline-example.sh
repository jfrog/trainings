#/bin/bash

if [ ! -z "$1" ]; then
    echo "[ERROR] No JFrog Project key  "    
fi


cd ../../common/java

MY_PROJ_KEY=""
MY_IMAGE="${JFROG_SAAS_DNS}/${MY_PROJ_KEY}-docker/java-app:1.0.0"
    
echo "*****************************"
echo "**** SCAN DEPENDENCIES"  
echo "*****************************"

# scan dependencies before the build
jf audit --watches CI --fail=false

echo "*****************************"
echo "**** BUILD APP"  
echo "*****************************"

# build app
mvn clean package deploy

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

# scan all the layers of the generated image (including the base image's layers)
jf docker scan $MY_IMAGE --fail=false

echo "*****************************"
echo "**** PUSH IMAGE TO ARTIFACTORY"  
echo "*****************************"

docker push $MY_IMAGE
