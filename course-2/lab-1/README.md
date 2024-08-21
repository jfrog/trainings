# Lab: Artifact management basics

## Goals

Perform basics actions via the UI & API regarding artifacts management

## Pre requisites

Create the following repository via the UI :

Repo type | Repo key | Package type | Environment | Comment
---|---|--- |---|---
LOCAL | [USERNAME]-generic-test-local | GENERIC | DEV |

## Upload / Download via the REST API

1. Upload a random file

```bash
echo "Hello World" > test.txt

curl \
   -X PUT \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -d "@test.txt" \
$JFROG_SAAS_URL/artifactory/<USERNAME>-generic-test-local/test.txt
```

2. Delete the file from your local machine.
3. Download the file using the REST API:

```bash
curl \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
$JFROG_SAAS_URL/artifactory/<USERNAME>-generic-test-local/test.txt
```

## Upload / Download via the JFrog CLI

1. Create multiple text files

```bash
# This is a Linux command. If you're using Windows you can create the files manually or find the Windows equivalent - what takes faster
for d in monday tuesday wednesday thursday; do echo "Hello $d \!" > ${d}.txt ; done
```

2. Upload multiple files to the repository using the JFrog CLI:

```bash
jf rt upload "*.txt" <USERNAME>-generic-test-local/cli-tests/
```

3. Download the content of a folder from the repository into your local machine:

```bash
jf rt download <USERNAME>-generic-test-local/cli-tests/ .
```

## Apply properties via the UI

1. In the artifacts browser view, navigate to the file you just uploaded.
2. Navigate to the `Properties` tab.
3. Add the following properties :
   + `app.name` with the value `snake`
   + `app.version` with the value `1.0.0`

## [OPTIONAL] Apply properties via the REST API

Assign the following properties to a file

```bash
curl \
   -X PUT \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
"$JFROG_SAAS_URL/artifactory/api/storage/<USERNAME>-generic-test-local/cli-tests/monday.txt?properties=os=win,linux;qa=done"
```

## [OPTIONAL] Apply properties via the JFrog CLI

Assign the following properties to a file

+ runtime.deploy.datetime=20240219_08000
+ runtime.deploy.account=robot_sa

by executing the following command (don't forget to update the repository key)

```bash
jf rt sp "<USERNAME>-generic-test-local/test.txt" "runtime.deploy.datetime=20240219_08000;runtime.deploy.account=robot_sa"
```

## Search for artifacts with Artifactory Query Language (AQL)

> Here is the [official documentation for AQL](https://jfrog.com/help/r/jfrog-rest-apis/artifactory-query-language)

1. Update the following files with your own repository key

+ **query-aql-properties-rest.txt**
+ **query-aql-cli.json**

Execute the following commands

```bash

# Run an AQL query via the API
jf rt curl -XPOST -H "Content-type: text/plain" api/search/aql -d"@query-aql-properties-rest.txt"

# Run an AQL query via the JFrog CLI
jf rt s --spec="query-aql-cli.json"
```

## [OPTIONAL] Search for artifacts with GraphQL

> Here is the [official documentation for GraphQL](https://jfrog.com/help/r/jfrog-rest-apis/graphql)

```bash
# the JFrog CLI rt curl command doesn't target metadata/api
# we have to use curl
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d "@query-graphql.json" \
"$JFROG_SAAS_URL/metadata/api/v1/query" 
```

### [OPTIONAL] GraphiQL

1. In your browser, go to  `$JFROG_SAAS_URL/metadata/api/v1/query/graphiql`and specify your access token
2. Extract the query from the JSON file  '{"query" : "<QUERY_TO_EXTRACT>"}  from `../../demos/basics-search/query-graphql.json`
3. Paste it in the query editor and execute it

## Create permission targets via the API

> **IMPORTANT NOTE** : From Artifactory V7.72.0, the permission targets are managed by JFrog Access (internal microservice) and so the official API endpoint is ```access/api/v2/permissions```. The previous API endpoint ```artifactory/api/v2/security/permissions``` is still maintained for the moment but will be deprecated in the future (no ETA).

> Here is the [official documentation on the API](https://jfrog.com/help/r/jfrog-rest-apis/permissions)

Create the following groups: USERNAME_developers, USERNAME_uploaders

Create the following permission target(s) :

Permission name | Resources | Population | Action | Comment
---|---|--- |--- |---
USERNAME_developers | All Remote  | developers group | Read, Deploy/Cache
USERNAME_uploaders  | All Remote + All local | uploaders group | Read, Deploy/Cache, Delete/Overwrite

By using the following command(DONT FORGET to update pt-api-def-latest.json with your permission name and group name)

```bash
curl \
   -X POST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"pt-api-def-latest.json" \
$JFROG_SAAS_URL/access/api/v2/permissions/
```

## [OPTIONAL] Create permission targets via the JFrog CLI

> relies on [```artifactory/api/v2/security/permissions```](https://jfrog.com/help/r/jfrog-rest-apis/create-permission-target)

Create the following permission target(s) :

Permission name | Resources | Population | Action | Comment
---|---|--- |--- |---
USERNAME_consumers  | All Remote + All local | USERNAME_uploaders group | Read, Annotate

```bash
# generate 1 permission target definition and store it into permissions.json
jf rt ptt pt-cli-template.json

# apply 1 permission target definition
jf rt ptc pt-cli-template.json
```

## Creating Scoped Tokens

> Here is the [official documentation for Tokens](https://jfrog.com/help/r/jfrog-rest-apis/access-tokens)

### Identity token

Generate an identity token (will inherit the permission related to the current user) by executing the following command

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -d "scope=applied-permissions/user" \
$JFROG_SAAS_URL/access/api/v1/tokens
```

### Scoped token

Generate a token based on groups (will inherit the permission related to the groups) by executing the following command

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -d "scope=applied-permissions/groups:USERNAME_uploaders" \
$JFROG_SAAS_URL/access/api/v1/tokens
```

### [OPTIONAL] Scoped token for a transient user (non existing user)

> a token can be [refreshed](https://jfrog.com/help/r/jfrog-rest-apis/refresh-token)

Generate a transient user (will inherit the permission related to the specified groups) by executing the following command

```bash
# the token will expire in 300 seconds and can be refreshed
# it has to be executed by an Admin
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -d "username=ninja" \
   -d "refreshable=true" \
   -d "expires_in=300" \
   -d "scope=applied-permissions/groups:USERNAME_developers" \
$JFROG_SAAS_URL/access/api/v1/tokens
```
