#!/bin/bash

maven_repo="green-maven"
project_key=""

which jf >/dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "[ERROR] JFrog CLI not found. "
    exit 1
fi

echo "[INFO] $(jf -v)"

if [ ! -z "$1" ]; then
    maven_repo=$1
fi
echo "[INFO] Maven repository set : $maven_repo "

if [ ! -z "$2" ]; then
    export JFROG_CLI_BUILD_PROJECT=$2
    echo "[INFO] JFrog Project key : $2 "    
fi


cd ../../common/java

# Create build configuration:
export JFROG_CLI_BUILD_NAME=green-app  \
        JFROG_CLI_BUILD_NUMBER=1 \
        JFROG_CLI_BUILD_URL="https://myCI.com" \

jf mvnc \
    --repo-deploy-releases $maven_repo \
    --repo-deploy-snapshots $maven_repo \
    --repo-resolve-releases $maven_repo \
    --repo-resolve-snapshots $maven_repo

# generate BOM during the maven build and deploy
jf mvn clean package deploy 

# collect env var + git info + publish BOM to Artifactory
jf rt bce && jf rt bag && jf rt bp

cd -