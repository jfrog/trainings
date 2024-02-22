# Demo: Curation Workflow

## Enable curation

1. Ensure that Curation is enabled ("Administration" -> "Curation" -> "General" -> "Curation Service Activation").
2. Under "Administration" -> "Curation" -> "Curated Repositories", click the "State" toggle next to `mavencentral-remote`.

## Create a curation policy

1. Switch to the "Application" sidebar, and navigate to "Curation" -> "Policies Management", and click "Create New Policy".
   1. Policy Name: `curation-workflow-demo`
   2. Repositories: "Specific", and then select `mavencentral-remote`.
   3. Policy Condition: "CVE with CVSS score of 9 or above (with or without a fix)".
   4. Waivers: None (just click "Next").
   5. Actions: "Dry Run". Also select "Notify by Email" and enter your email address.
   6. Click "Next", and then "Save Policy".

## Test the curation process

1. Ensure that your machine doesn't have Log4J cached, delete the entire `~/.m2/repositoryorg/apache/logging` directory tree, if it exists.
2. On your own machine, using a command prompt, navigate to the [common Java module](../../common/java).       Configure your Maven client to download packages from your remote
    1. Artifactory > virtual repositories > <PROJECT_KEY>-maven
    2. Click on  `Setup Client` & follow the instruction

### Block download

1. Delete the entire `org/apache/logging` directory tree, if it exists.
2. Change the curation policy's action to "Block" (instead of "Dry run").
3. Delete Log4J from the remote repository's cache (`mavencentral-remote-cache`).
