# Lab: Repository Creation

## Goals

Be familiar with the API, the JFrog CLI, JFrog's Terraform provider capabilities

## Create a repository structure using the Rest API

> Come up with a ```<PROJECT_KEY>``` which will be used as prefix for all your repositories(the project key can be your NAME)

Create the following repositories using the Rest API

Repo type | Repo key | Package type | Environment | Comment
---|---|--- |---|---
LOCAL | <PROJECT_KEY>-maven-dev-local | MAVEN | DEV |
LOCAL | <PROJECT_KEY>-maven-rc-local | MAVEN | DEV |
LOCAL | <PROJECT_KEY>-maven-release-local | MAVEN | PROD |
LOCAL | <PROJECT_KEY>-maven-prod-local | MAVEN | PROD |
REMOTE | mavencentral-remote | MAVEN | DEV |
VIRTUAL | <PROJECT_KEY>-maven | MAVEN | DEV | include the 3 repos above and set default deployement to  <PROJECT_KEY>-maven-rc-local

Use the following cURL command to create one repository at a time. You can edit the JSON payload located in **repo-api-def.json** or create a new one for each execution

```bash
# be careful the repository key has to be part of the URL and match the "key" in the JSON payload !
# you can use the help of the docs for virtual -> https://jfrog.com/help/r/jfrog-rest-apis/repository-configuration-json
curl \
   -X PUT \
      -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
      -H "Content-Type: application/json" \
      -d "@repo-api-def.json" \
      $JFROG_SAAS_URL/artifactory/api/repositories/<REPO_KEY>
```

## Create a repository structure using the JFrog CLI

> with this option, you rely on templates (that you can parameterize) for creating your repositories

Create the following repositories :

Repo type | Repo key | Package type | Environment | Comment
---|---|--- |---|---
LOCAL | <PROJECT_KEY>-docker-dev-local | DOCKER |DEV |
LOCAL | <PROJECT_KEY>-docker-rc-local | DOCKER |DEV |
LOCAL | <PROJECT_KEY>-docker-release-local | DOCKER |PROD |
LOCAL | <PROJECT_KEY>-docker-prod-local | DOCKER | PROD |
REMOTE | dockerhub-remote | DOCKER | DEV |
VIRTUAL | <PROJECT_KEY>-docker | DOCKER | DEV | include the oci repos above and set default deployement to  <PROJECT_KEY>-oci-rc-local

1. Use the repository creation template command to generate a JSON file describing the repository:

   ```bash
   jf rt rpt repository.json
   ```

   This is a command-line "wizard". Use the `tab` key and arrow keys to go through the wizard.
   The only thing you are required to provide is the repository's name, class (local/remote/virtual), and
   package type. Then, you may either continue providing optional information, or end the wizard using `:x`.
2. Look at the generated `repository.json` file. It contains the repository creation parameters.
3. Use the JFrog CLI to create the repository according to the created JSON file:

   ```bash
   jf rt rc repository.json
   ```

4. Now let's use some advanced capabilities by executing this command(for linux users, for windows find the equivalent or skip) :

   ```bash
   for maturity in rc release prod; do 
      jf rt rc --vars "team=PROJECT_KEY;pkgType=docker;maturity=$maturity;" repo-cli-template.json 
   done
   ```

## [OPTIONAL] Create a repository structure using the Rest API (YAML PATCH)

> with this option, you can create multiple repositories in 1 API call. However you can't :
>
> - parameterize your repo configuration
> - set the environment field

Create the following repositories :

Repo type | Repo key | Package type | Environment | Comment
---|---|--- |---|---
LOCAL | <PROJECT_KEY>-npm-dev-local | NPM | DEV |
LOCAL | <PROJECT_KEY>-npm-rc-local | NPM |DEV |
LOCAL | <PROJECT_KEY>-npm-release-local | NPM |PROD |
LOCAL | <PROJECT_KEY>-npm-prod-local | NPM | PROD |
REMOTE | npmjs-remote | NPM |DEV |
VIRTUAL | <PROJECT_KEY>-npm | NPM | DEV | include the repos above and set default deployement to  <PROJECT_KEY>-rc-npm-local
LOCAL | <PROJECT_KEY>-generic-dev-local | GENERIC |DEV |
LOCAL | <PROJECT_KEY>-generic-rc-local | GENERIC | DEV |
LOCAL | <PROJECT_KEY>-generic-release-local | GENERIC | PROD |
LOCAL | <PROJECT_KEY>-generic-prod-local | GENERIC | PROD |
VIRTUAL | <PROJECT_KEY>-generic | GENERIC | DEV | include the generic repos above and set default deployement to  <PROJECT_KEY>>-generic-rc-local

```bash
   # NOTES :
   #   - update repo-api-def-all.yaml with your values
   #   - don't use -d option to specify the YAML file
   #   - environment field cannot be set (yet)
   jf rt curl \
         -X PATCH \
         -H "Content-Type: application/yaml" \
         -T @repo-api-def-all.yaml \
         api/system/configuration
```

## [OPTIONAL] Create a repository structure using the JFrog's Terraform Provider

Follow the terraform demo in https://github.com/jfrog/trainings/tree/main/demos/advanced-repositories at the bottom. 
