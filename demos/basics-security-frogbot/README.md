# Demo: Frogbot

## Pre requisites

1. 1 JFrog project with a project key = **green**
2. the following repositories assigned to the JFrog Project

    Repo type | Repo key | Environment | Comment
    ---|---|--- |---
    REMOTE | mavencentral-remote | DEV |

## Demo

1. In GitHub's "Actions" section, show the `Frogbot Scan Repository` workflow. The workflow is set up to only
   run on-demand.
2. Click the `Run Workflow` button and follow its progress.
3. Create a branch, and introduce some change in it (such as adding a text file).
4. Create a pull request.
5. Watch how the `Frogbot Scan Pull Request` workflow is being run automatically.
