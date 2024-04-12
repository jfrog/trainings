#!/bin/bash

# param 1 : programming language
# param 2 : virtual repo for resolution
# param 3 : virtual repo for push 
# param 4 : virtual repo for container push 
# param 5 : project key

language=java
download_repo="green-maven"
upload_repo="green-maven"
oci_repo="green-oci"
jpd="yann-demo.dev.gcp.jfps.team"
container_cmd="nerdctl"

which jf >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "[ERROR] JFrog CLI not found. "
    exit 1
fi
echo "[INFO] $(jf -v)"

if [ ! -z "$1" ]; then
    language=$1
fi
echo "[INFO] Code language : $language "

if [ ! -z "$2" ]; then
    download_repo=$2
fi
echo "[INFO] Repository for download : $download_repo "

if [ ! -z "$3" ]; then
    upload_repo=$3
fi
echo "[INFO] Repository for upload   : $upload_repo "


if [ ! -z "$4" ]; then
    oci_repo=$4
fi
echo "[INFO] Repository for upload (container)  : $oci_repo "

if [ ! -z "$5" ]; then
    export JFROG_CLI_BUILD_PROJECT=$5
    echo "[INFO] JFrog Project key : $5 "    
else 
    echo "[INFO] No JFrog Project key set"    
fi

# to do : verify java version >= 21

pushd .

cd common/$language

# Create build configuration:
export JFROG_CLI_BUILD_NAME=$(echo $upload_repo | cut -d '-' -f1)-${language}-app  \
        JFROG_CLI_BUILD_NUMBER=1 \
        JFROG_CLI_BUILD_URL="https://myCI.com" \

if [[ $language == "java" ]]; then
    jf mvnc \
        --repo-deploy-releases $upload_repo \
        --repo-deploy-snapshots $upload_repo \
        --repo-resolve-releases $download_repo \
        --repo-resolve-snapshots $download_repo

    # generate BOM during the maven build and deploy
    jf mvn clean -U package deploy 

    # prepare container image build
    cp target/demo*.jar .

else
    jf npmc --repo-resolve $download_repo 

    # generate BOM during the maven build and deploy
    jf npm ci  --module my-app

    tar -czf app.tar.gz --exclude Dockerfile --exclude "*tar.gz" .

    jf rt u app.tar.gz $upload_repo --module my-app
fi

# collect env var + git info + publish BOM to Artifactory
jf rt bce &&  jf rt bp


eval $container_cmd  build  \
    --build-arg REGISTRY=$jpd \
    --build-arg DOCKER_REPO=$oci_repo \
    -t $jpd/$oci_repo/$language-demo:0.1.0 .
eval $container_cmd push $jpd/$oci_repo/$language-demo:0.1.0

popd