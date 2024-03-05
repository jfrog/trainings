# Demo: Search Capabilities

## Pre requisites

1. the following repositories (not relate to any JFrog Project)

    Repo type | Repo key | Environment | Comment
    ---|---|--- |---
    LOCAL | oci-dev-local | DEV |
    LOCAL | oci-rc-local | DEV |
    LOCAL | oci-release-local | PROD |
    LOCAL | oci-prod-local | PROD |

2. Publish a container image in `oci-dev-local` and apply on the `manifest.json` the following custom properties :
    + app.name=snake
    + app.version=1.0.0

## Search using AQL

+ based on custom properties

```bash
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: text/plain" \
    -d "@query-aql-properties-rest.txt" \
$JFROG_URL/artifactory/api/search/aql
```

+ based on size (docker layer size)

```bash
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: text/plain" \
    -d "@query-aql-size-rest.txt" \
$JFROG_URL/artifactory/api/search/aql
```

## Search using GraphQL

+ based on custom properties

```bash
# do not format the query-graphql.json with line breaks and indentation
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -d "@query-graphql.json" \
$JFROG_URL/metadata/api/v1/query 
```

+ based on size (docker layer size)

cannot be achieved with GraphQL

> you can use a UI to run GraphQL queries on $JFROG_URL/metadata/api/v1/query/graphiql. Extract your query from the JSON file  '{"query" : "<QUERY_TO_EXTRACT>"} and paste it in the query editor'

## Search with filespec through CLI

```bash
jf rt s --spec=query-aql-cli.json
```
