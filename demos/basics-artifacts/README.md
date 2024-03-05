# Demo: Artifact management basics

## Pre requisites

Repo type | Repo key | Environment | Comment
---|---|---|---
LOCAL | green-generic-test-local | DEV |

## Upload via the REST API

```bash
   curl \
      -X PUT \
      -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
      -d "@test.txt" \
   $JFROG_SAAS_URL/artifactory/green-generic-test-local/test.txt
```

## Download via the REST API

```bash
   curl \
      -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   $JFROG_SAAS_URL/artifactory/green-generic-test-local/test.txt
```

## Upload via the JFrog CLI

```bash
   jf rt upload "*.txt" green-generic-test-local/cli-tests/
```

## Download via the JFrog CLI

```bash
   jf rt download green-generic-test-local/cli-tests/ .
```

## Apply properties via the UI

1. In the artifacts browser view, navigate to the file you just uploaded.
2. Navigate to the `Properties` tab.
3. Add the following properties :
   + `app.name` with the value `snake`
   + `app.version` with the value `1.0.0`

## Apply properties via the REST API

```bash
   curl \
      -X PUT \
      -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   "$JFROG_SAAS_URL/artifactory/api/storage/green-generic-test-local/test.txt?properties=os=win,linux;qa=done"
```

## Apply properties via the JFrog CLI

```bash
   jf rt sp "runtime.deploy.datetime=20240219_08000;runtime.deploy.account=robot_sa" green-generic-test-local/cli-tests/test.txt .
```
