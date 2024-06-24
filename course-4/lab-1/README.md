# Lab: Curation workflow

> Here is the [official documentation for JFrog Curation](https://jfrog.com/help/r/jfrog-curation/jfrog-curation-workflow)

## Goal

Setup a curation process to protect your developers

## Pre requisites

Repo type | Repo key | Environment | Comment
---|---|--- |---
REMOTE | <YOUR_NAME>-mavencentral-remote | DEV |
VIRTUAL | <YOUR_NAME>-maven  | DEV | include the above repo
REMOTE | <YOUR_NAME>-npmjs-remote | DEV |
VIRTUAL | <YOUR_NAME>-npm  | DEV | include the above repo

Clean your NPM cache by running `npm cache clean --force`

## Enable curation

1. Ensure that Curation is enabled ("Administration" -> "Curation" -> "General" -> "Curation Service Activation").
2. Under "Administration" -> "Curation" -> "Curated Repositories", click the "State" toggle next to `<YOUR_NAME>-npmjs-remote`

## Create a curation policy

1. Switch to the "Application" sidebar, and navigate to "Curation" -> "Policies Management", and click "Create New Policy".
   1. Policy Name: `<YOUR_NAME>_malicious_packages`
   2. Repositories: "Specific", and then select `<YOUR_NAME>-npmjs-remote`.
   3. Policy Condition: "Malicious package".
   4. Waivers: None (just click "Next").
   5. Actions: "Block". Also select "Notify by Email" and enter your email address.
   6. Click "Next", and then "Save Policy".

## Test the curation process

1. Configure your NPM client to download packages from your remote
    1. Artifactory > virtual repositories > <YOUR_NAME>-npm
    2. Click on  `Setup Client` & follow the instruction
    3. Make sure in your `~/.npmrc` that the ```_authToken``` is specified and NOT ```_auth```

    ```text
        //yann-sbx.jfrog.io/artifactory/api/npm/test-npm/:_authToken=cmVm*****
        always-auth=true
        email=yannc@jfrog.com
        registry=https://yann-sbx.jfrog.io/artifactory/api/npm/test-npm/
    ```

3. Try downloading a malicious package, such as `cors.js`:

   ```bash
   npm install cors.js
   ```

4. Navigate to "Curation" -> "Audit". You should see the blocked action there(Update the time to past 7 days).
