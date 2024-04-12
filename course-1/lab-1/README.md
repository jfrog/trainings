# Lab: Artifact management basics

## Goals

Perform basics actions via the UI & API regarding artifacts management

## Create a repository using the UI

1. Navigate to "Artifactory" -> "Repositories"
2. Create a new generic repository and name it  `<USERNAME>-generic-test-local`

## Upload / Download

### Using the UI

1. Create a sample text file on your local machine, such as `test.txt`.
2. Navigate to the artifacts browser ("Artifactory" -> "Artifacts"), and focus on your new repository.
3. Click the "Deploy" button at the top right.
4. Drag and drop your text file into the "Single Deploy" box.
5. Click the "Deploy" button.
6. Once the file is uploaded, navigate to it using the navigation bar on the left and focus on it.
7. Click the "Download" button on the top right (a downward pointing arrow) and download the file.
8. Delete the artifact from the repository. Click the button with the three vertical dots and select "Delete".

### Using the REST API

> Here is the [official documentation for the JFrog CLI](https://jfrog.com/help/r/jfrog-rest-apis/deploy-artifact-apis)

1. Upload the same file but in a folder within the same repository
2. Delete the file from your local machine.
3. Download the file

### Using the JFrog CLI

> Here is the [official documentation for the JFrog CLI](https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/cli-for-jfrog-artifactory/generic-files)

1. Open a command-line window, and browse to the directory containing your file.
2. Upload the file to the repository
3. Download the file from the repository into your local machine

## Applying property

### Using the UI

1. In the artifacts browser view, navigate to the file you just uploaded.
2. Navigate to the `Properties` tab.
3. Add the following properties:
   + `app.name` with the value `snake`
   + `app.version` with the value `1.0.0`

### Using the JFrog CLI

> Here is the [official documentation for the JFrog CLI](https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/cli-for-jfrog-artifactory/generic-files#setting-properties-on-files)

Apply the following properties:

+ `runtime.deploy.datetime` set with the value `20240219_08000`
+ `runtime.deploy.account` set with the value `robot_sa`

### Searching for artifacts

#### AQL

> Here is the [official documentation for the AQL](https://jfrog.com/help/r/jfrog-artifactory-documentation/artifactory-query-language)

Via an AQL query, look for artifacts tagged with the following properties:

+ `app.name=snake`
+ `app.version=1.0.0`

Use the following command to run an AQL query and make sure to update the AQL query accordingly.

```bash
# we supposed we are in jfrog-training/course-1/lab-1 folder

# using the API
jf rt curl -XPOST -H "Content-type: text/plain" api/search/aql -d"@../../demos/basics-search/query-aql-properties-rest.txt"
```

##### OPTIONAL : Using the JFrog CLI with Filespecs

> Here is the [official documentation for the filespecs](https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/cli-for-jfrog-artifactory/using-file-specs#overview)

Execute the same AQL query by embedding it into a Filespec, which then can be consumed by the JFrog CLI.

Use the following command to run an AQL query via the JFrog CLI and make sure to update the AQL query accordingly.

```bash
# using the JFrog CLI
jf rt search --spec="../../demos/basics-search/query-aql-cli.json"
```

#### GraphQL

> Here is the [official JFrog documentation for GraphQL](https://jfrog.com/help/r/jfrog-rest-apis/graphql)

##### GraphiQL

1. In your browser, go to  `$JFROG_SAAS_URL/metadata/api/v1/query/graphiql` and specify your access token
2. Extract the GraphQL query from the JSON file  '{"query" : "<QUERY_TO_EXTRACT>"}  from `../../demos/basics-search/query-graphql.json`
3. Paste it in the query editor and execute it

##### OPTIONAL : Using the REST API

Use the following command to run an AQL query and make sure to update the AQL query accordingly

```bash
# the JFrog CLI rt curl command doesn't target metadata/api
# we have to use curl
curl \
    -XPOST \
    -H "Content-Type: application/json" \
    -d "@../../demos/basics-search/query-graphql.json" \
$JFROG_SAAS_URL/metadata/api/v1/query 
```
