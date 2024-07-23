# Lab: Scans in CI pipelines

## Goals

* Understand how to use JFrog scans in your CI pipelines
* Understand when to use JFrog scans in your CI pipelines

## Prerequisites
* Create a policy with some criterias (like minimal High severity) - You can use policies that you have already created
* Create a watch with the "CI" name, and include the policy you've created. Make sure to include repositories with data, like docker, npm from previous labs  

## Audit / Dependency scan

1. In a terminal, go to `common/java`, and run these commands:
   ```bash
   # scan dependencies before the build
   jf audit --watches CI --fail=false

   echo $?
   ```

2. Create a shell script which reproduces the main steps of a simple CI pipeline. You can reference secured-pipeline-example.sh script:

   1. pull dependencies
   2. scan dependencies
   3. [OPTIONAL] compile / build the app
   4. package the application
   5. push the application to Artifactory

## On Demand scan

1. In a terminal, go to `common/java`, and run these commands:

   ```bash
   # scan the result of the maven build
   mvn clean package
   jf scan target/*.jar --watches CI --fail=false

   echo $?
   ```
2. In a terminal, go to `common/js`, and run these commands:
   ```bash
   # scan a docker image
   docker build -t js-app:1.0.0 .
   jf docker scan  js-app:1.0.0 --watches CI --fail=false
   ```

3. Update your shell script by scanning the artifact representing your application. You can reference secured-pipeline-example.sh script:
