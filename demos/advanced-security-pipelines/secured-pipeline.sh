#/bin/bash

cd ../../common/java

MY_PROJ_KEY=""
MY_IMAGE="<SAAS_DNS>/${MY_PROJ_KEY}-docker/java-app:1.0.0"
    
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
    --build-arg REGISTRY=<SAAS_DNS> \
    --build-arg DOCKER_REPO=${MY_PROJ_KEY}-docker \
.

echo "*****************************"
echo "**** SCAN CONTAINER IMAGE"  
echo "*****************************"

# scan the layers of the base image
jf docker scan $MY_IMAGE --fail=false

echo "*****************************"
echo "**** PUSH IMAGE TO ARTIFACTORY"  
echo "*****************************"

docker push $MY_IMAGE
