# Lab: Repository Creation

## Goals

Be familiar with the API, the JFrog CLI, JFrog's Terraform provider capabilities

## Create a repository structure using the Rest API

Create the following repositories :

Repo type | Repo key | Environment | Comment
---|---|--- |---
LOCAL | <PROJECT_KEY>-dev-maven-local | DEV |
LOCAL | <PROJECT_KEY>-rc-maven-local | DEV |
LOCAL | <PROJECT_KEY>-release-maven-local | PROD |
LOCAL | <PROJECT_KEY>-prod-maven-local | PROD |
REMOTE | mavencentral-remote | DEV |
VIRTUAL | <PROJECT_KEY>-maven  | DEV | include the 3 repos above and set default deployement to  <PROJECT_KEY>-rc-maven-local

Assign a value to ```<PROJECT_KEY>```

Use the REST API to create the repositories

```bash
# be careful the repository key has to be part of the URL and match the "key" in the JSON payload !
curl \
   -X PUT \
      -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
      -H "Content-Type: application/json" \
      -d "@../../demos/advanced-repository/payload/repo-api-def.json" \
      $JFROG_SAAS_URL/artifactory/api/repositories/<REPO_KEY>
```

## Create a repository structure using the JFrog CLI

Create the following repositories :

Repo type | Repo key | Environment | Comment
---|---|--- |---
LOCAL | <PROJECT_KEY>-dev-oci-local | DEV |
LOCAL | <PROJECT_KEY>-rc-oci-local | DEV |
LOCAL | <PROJECT_KEY>-release-oci-local | PROD |
LOCAL | <PROJECT_KEY>-prod-oci-local | PROD |
REMOTE | dockerhub-remote | DEV |
VIRTUAL | <PROJECT_KEY>-oci | DEV | include the oci repos above and set default deployement to  <PROJECT_KEY>-rc-oci-local

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

4. Now let's use some advanced capabilities by executing this command :

   ```bash
   for maturity in "rc release prod"; do 
      jf rt rc --vars "team=blueteam;pkgType=npm;maturity=$maturity;" ../../demos/advanced-repositories/repo-cli-template.json 
   done
   ```

## Create a repository structure using the Rest API (YAML PATCH)

Create the following repositories :

Repo type | Repo key | Environment | Comment
---|---|--- |---
LOCAL | <PROJECT_KEY>-dev-npm-local | DEV |
LOCAL | <PROJECT_KEY>-rc-npm-local | DEV |
LOCAL | <PROJECT_KEY>-release-npm-local | PROD |
LOCAL | <PROJECT_KEY>-prod-npm-local | PROD |
REMOTE | npmjs-remote | DEV |
VIRTUAL | <PROJECT_KEY>-npm  | DEV | include the repos above and set default deployement to  <PROJECT_KEY>-rc-npm-local
LOCAL | <PROJECT_KEY>-dev-generic-local | DEV |
LOCAL | <PROJECT_KEY>-rc-generic-local | DEV |
LOCAL | <PROJECT_KEY>-release-generic-local | PROD |
LOCAL | <PROJECT_KEY>-prod-generic-local | PROD |
VIRTUAL | <PROJECT_KEY>-generic  | DEV | include the generic repos above and set default deployement to  <PROJECT_KEY>-rc-generic-local

```bash
   # don't use -d option to specify the YAML file
   # environment field cannot be set (yet)
   jf rt curl \
         -X PATCH \
         -H "Content-Type: application/yaml" \
         -T @../../demos/advanced-repositories/payload/repo-api-def-all.yaml \
         api/system/configuration
```

## Create a repository structure using the JFrog's Terraform Provider

An example Terraform module is provided: [repository-create.tf](repository-create.tf).
create my.tfvars with the following variables :

+ artifactory_url
+ artifactory_access_token

**More info on the [JFrog official doc](https://registry.terraform.io/providers/jfrog/artifactory/latest/docs)**

```bash
# download the provider
terraform init

# check changes to be applied
terraform plan --var-file=my.tfvars

# apply changes 
terraform apply --var-file=my.tfvars

# remove changes
terraform destroy --var-file=my.tfvars
```
