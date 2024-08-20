# Lab: Publish JFrog BOMs

## Goals

* Understand how to generate and publish a Build Info in a CI pipeline
* Understand how to generate and publish a Release Bundle V2 in a CI pipeline

## Generate and Publish a Build Info

> Here is the [official documentation for generating Build Info per package manager](https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/cli-for-jfrog-artifactory/package-managers-integration)

1. Update the script from Lab 4 and inject the JFrog CLI :
   1. Package manager configuration
   2. During Build and/or Upload to generate the Build Info
   3. After the Build phase to collect info on the CI pipeline + publish the Build Info

## Generate and Publish a Release Bundle V2

> Here is the [official documentation for RBv2 API](https://jfrog.com/help/r/jfrog-rest-apis/release-lifecycle-management)

1. Create a RBv2 from the previously pushed Build Info
   - Do it manually from the UI
   - (optional) Update the script from Lab 4 and inject the JFrog CLI creation of RBv2
