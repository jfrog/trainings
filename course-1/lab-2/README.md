# Lab: JFrog Projects basics

## Goals

Practice managing JFrog Projects

> Here is the [official documentation for the JFrog Projects](https://jfrog.com/help/r/jfrog-platform-administration-documentation/get-started-with-projects)

via the UI:

## As the Platform admin

1. Create a 2 users and name respectively ```sunday``` and ```monday```
2. Create a JFrog Project
3. Onboard the user ```sunday``` as a Project Admin

## As the Project admin (sunday)

1. Create a generic repository and assign the ```DEV``` environment
2. Onboard the user ```monday``` as a Project Admin and grant the role ```Developer```

## As the Project user (monday)

Perform uploads/downloads to the previously created generic repository

## OPTIONAL

Implement the following use case :

QA can only download artifacts from the "Release Candidate" repository

1. Create a project environment called ```QA```
2. Create the <PROJECT-KEY>-oci-rc-local repository and assign it the ```QA```environment
3. Create a new role called ```Testers``` :
    + Assign it the ```QA```environment
    + Enable only read access
4. Assign the ```Testers``` role to a user
