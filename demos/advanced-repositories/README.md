# Demo: Repository creation automation

**NOTE**: The [JSON structure for the REST API](https://jfrog.com/help/r/jfrog-rest-apis/repository-configuration-json) may not be  identical to the structure consumed by the CLI.

## Using the Rest API

```bash
# be careful the repository key has to be part of the URL and match the "key" in the JSON payload !
curl \
   -X PUT \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d "@payload/repo-api-def.json" \
$JFROG_SAAS_URL/artifactory/api/repositories/blueteam-maven-archive-local
```

## Using the JFrog CLI

### Repository templates

```bash
   
   # create a repository config template 
   jf rt rpt repository.json

   # create a repository based on the config template
   jf rt rc repository.json
```

Example of using variables in the repo config templates

```bash
   for maturity in `rc release prod`; do jf rt rc --vars "team=blueteam;pkgType=npm;maturity=$maturity;" repo-cli-template-example.json ; done
```

### PATCH config

```bash
# don't use -d option to specify the YAML file
# environment field cannot be set (yet)
jf rt curl \
    -X PATCH \
    -H "Content-Type: application/yaml" \
    -T payload/repo-api-def-all.yaml \
    api/system/configuration
```

### Using JFrog's Terraform Provider

An example Terraform module is provided: [repository-create.tf](repository-create.tf).
Create ```my.tfvars``` and assign the following variables :

+ artifactory_url
+ artifactory_access_token
+ artifactory_local_maven_repository

**More info on the [JFrog official doc](https://registry.terraform.io/providers/jfrog/artifactory/latest/docs)**

```bash
# download the provider
terraform init

# check changes to be applied
terraform plan -var-file=my.tfvars

# apply changes
terraform apply -var-file=my.tfvars

# remove changes
terraform destroy -var-file=my.tfvars
```
