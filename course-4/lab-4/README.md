# Lab: Scans in CI pipelines

## Goals

* Understand how to use JFrog scans in your CI pipelines
* Understand when to use JFrog scans in your CI pipelines

## Audit / Dependency scan

1. In a terminal, run this commands :

   ```bash

   cd ../../common/java

   # scan dependencies before the build
   jf audit --watches CI --fail=false

   echo $?
   ```

2. Create a shell script which reproduces the main steps of a simple CI pipeline:  

   1. pull dependencies
   2. scan dependencies
   3. [OPTIONAL] compile / build the app
   4. package the application
   5. push the application to Artifactory

## On Demand scan

1. In a terminal, run this commands :

   ```bash

   cd ../../common/java

   # scan the result of the maven build
   mvn clean package
   jf scan target/*.war --watches CI --fail=false

   echo $?
   
   # scan a docker image
   docker build -t java-app:1.0.0
   jf docker scan  java-app:1.0.0 --watches CI --fail=false
   ```

2. Update your shell script by scanning the artifact representing your application
