# Lab: Artifact management basics

## Goals

Perform basics actions via the UI & API regarding artifacts management

## Create a generic repository using the UI

Name it `<USERNAME>-test-generic-local`

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

1. Upload the file again using the REST API:

   ```bash
   curl -X PUT -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" -d "@test.txt" $JFROG_SAAS_DNS/artifactory/<USERNAME>-test-generic-local/test.txt
   ```

2. Delete the file from your local machine.

3. Download the file using the REST API:

   ```bash
   curl -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" $JFROG_SAAS_DNS/artifactory/<USERNAME>-test-generic-local/test.txt
   ```

### Using the JFrog CLI

1. Open a command-line window, and browse to the directory containing your file.
2. Upload the file to the repository using the JFrog CLI:

   ```bash
   jf rt upload test.txt <USERNAME>-test-generic-local/cli-tests/
   ```

3. Download the file from the repository into your local machine:

   ```bash
   jf rt download <USERNAME>-test-generic-local/cli-tests/test.txt .
   ```

## Applying property

### Using the UI

1. In the artifacts browser view, navigate to the file you just uploaded.
2. Navigate to the `Properties` tab.
3. Add the following properties :
   + `app.name` with the value `snake`
   + `app.version` with the value `1.0.0`

### Using the JFrog CLI

```bash
jf rt sp "runtime.deploy.datetime=20240219_08000;runtime.deploy.account=robot_sa" <USERNAME>-test-generic-local/cli-tests/test.txt .
```

### Searching for artifacts

#### AQL

```bash
# we supposed we are in jfrog-training/course-1/lab-1
jf rt curl -XPOST -H "Content-type: text/plain" api/search/aql -d"@../../demos/basics-search/query-aql-properties-rest.txt"

jf rt s --spec="../../demos/basics-search/query-aql-cli.json"
```

#### GraphQL

```bash
# the JFrog CLI rt curl command doesn't target metadata/api
# we have to use curl
curl \
    -XPOST \
    -H "Content-Type: application/json" \
    -d "@../../demos/basics-search/query-graphql.json" \
$JFROG_SAAS_DNS/metadata/api/v1/query 
```

#### GraphiQL

1. In your browser, go to  `$JFROG_SAAS_DNS/metadata/api/v1/query/graphiql`and specify your access token
2. Extract the query from the JSON file  '{"query" : "<QUERY_TO_EXTRACT>"}  from `../../demos/basics-search/query-graphql.json`
3. Paste it in the query editor and execute it
