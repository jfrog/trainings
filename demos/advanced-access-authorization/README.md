# Demo: Authorization

## Pre requisites

1. Create 'developers' group

## Permission Targets

UI:

1. Anonymous access
2. Show permission target (include / exclude patterns + actions)
3. Show Global roles at user and group level

API:

```bash
curl \
   -X POST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d "@payload/pt-api-def-latest.json" \
$JFROG_SAAS_URL/access/api/v2/permissions/
```

JFrog CLI:

> relies on [```artifactory/api/v2/security/permissions```](https://jfrog.com/help/r/jfrog-rest-apis/create-permission-target)

```bash

# apply 1 permission target definition
jf rt ptc --vars pt-name=test-permission pt-cli-template.json
```

## Tokens

UI:

1. Explain Identity tokens + Reference tokens
2. Show Set me up to generate identity tokens
3. Access Tokens (Scoped tokens)

### Identity token

Generate an identity token (will inherit the permission related to the current user)

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -d "scope=applied-permissions/user" \
$JFROG_SAAS_URL/access/api/v1/tokens
```

### Scoped token

Generate a token based on groups (will inherit the permission related to the groups)

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -d "scope=applied-permissions/groups:deployers" \
$JFROG_SAAS_URL/access/api/v1/tokens
```

### Scoped token for a transient user (non existing user)

> a token can be [refreshed](https://jfrog.com/help/r/jfrog-rest-apis/refresh-token)

Generate a transient user (will inherit the permission related to the specified groups)

```bash
# the token will expire in 300 seconds and can be refreshed
# it has to be executed by an Admin
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -d "username=amaya" \
   -d "refreshable=true" \
   -d "expires_in=300" \
   -d "scope=applied-permissions/groups:developers" \
$JFROG_SAAS_URL/access/api/v1/tokens
```
