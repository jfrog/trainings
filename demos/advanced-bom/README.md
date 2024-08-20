# Demo: JFrog BOMs

## Pre requisites

1. 1 JFrog project with a project key = **green**
2. the following repositories assigned to the JFrog Project

    Repo type | Repo key | Environment | Comment
    ---|---|--- |---
    LOCAL | green-maven-dev-local | DEV |
    LOCAL | green-maven-rc-local | DEV |
    LOCAL | green-maven-release-local | PROD |
    LOCAL | green-maven-prod-local | PROD |
    REMOTE | mavencentral-remote | DEV |
    VIRTUAL | green-maven  | DEV | include the 3 repos above and set default deployement to  green-rc-maven-local
3. Signing key called ```rbv2_no_pass```
4. Build Info published

## RBv2 creation via API

* from artifacts

```bash
# edit payload/rb_from_files.json, and update artifacts paths as you like
# create RBv2 from files
# the uploaded GPG key is called thekey, unless key name is different
# don't specify virtual repo
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
    -d @"payload/rb_from_files.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/release_bundle 
```

* from AQL

```bash
# create RBv2 from aql
# doesn't support build AQL domain (same as RBv1) !
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
    -d @"payload/rb_from_aql_ok.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/release_bundle 
```

* from existing Build Info

```bash
# edit payload/rb_from_builds.json, and update build_name, build_number according to your build info publish
# create RBv2 from multiple existing build info
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
    -d @"payload/rb_from_builds.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/release_bundle 
```

* from existing RBv2

```bash
# create RBv2 from multiple existing RBv2
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
    -d  @"payload/rb_from_rbs.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/release_bundle 
```

## RBv2 creation via the JFrog CLI - NOT WORKING, SKIP

> only support creation based on Build Info or RBv2

```bash
jf rbc --signing-key="thekey" --builds ./list_of_builds.json <RBv2_NAME> <RBv2_VERSION>
```

## RBv2 Promotion via API

Make sure the target repository is assigned the right environment

```bash
# under included_repository_keys put the relevant repositories that related to DEV environment according to the content of the RB: generic, maven, docker...
# rbv2 promotion
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
    -d @"payload/rb_promotion.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/promotion/records/rbv2_from_files/3.0.0 
```

## RBv2 Promotion via the JFrog CLI to PROD environment

```bash
jf rbp  --signing-key="thekey" --overwrite=true <RBv2_NAME> <RBv2_VERSION> <ENV>
```

## RBv2 Deletion via API

> No deletion via the JFrog CLI

```bash
# rbv2 deletion
# you have to specify the creation time in ms, use the Get RBv2 promotion to get that info
curl \
    -XDELETE \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "X-JFrog-Signing-Key-Name: thekey" \
"$JFROG_SAAS_URL/lifecycle/api/v2/promotion/records/rbv2_from_files/3.0.0/1708382591227?async=false" 
```
