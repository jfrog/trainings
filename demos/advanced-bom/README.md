# Demo: JFrog BOMs

## RBv2 creation via API

* from artifacts

```bash
# create RBv2 from files
# the uploaded GPG key is called rbv2_no_pass
# don't specify virtual repo
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: rbv2_no_pass" \
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
    -H "X-JFrog-Signing-Key-Name: rbv2_no_pass" \
    -d @"payload/rb_from_aql_ok.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/release_bundle 
```

* from existing Build Info

```bash
# create RBv2 from multiple existing build info
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: rbv2_no_pass" \
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
    -H "X-JFrog-Signing-Key-Name: rbv2_no_pass" \
    -d  @"payload/rb_from_rbs.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/release_bundle 
```

## RBv2 creation via the JFrog CLI

> only support creation based on Build Info or RBv2

```bash
jf rbc --signing-key="rbv2_no_pass" --builds ./list_of_builds.json <RBv2_NAME> <RBv2_VERSION>
```

## RBv2 Promotion via API

Make sure the target repository is assigned the right environment

```bash
# rbv2 promotion
curl \
    -XPOST \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-JFrog-Signing-Key-Name: rbv2_no_pass" \
    -d @"payload/rb_promotion.json" \
$JFROG_SAAS_URL/lifecycle/api/v2/promotion/records/rbv2_from_files/3.0.0 
```

## RBv2 Promotion via the JFrog CLI

```bash
jf rbp  --signing-key="rbv2_no_pass" --overwrite=true <RBv2_NAME> <RBv2_VERSION> <ENV>
```

## RBv2 Deletion via API

> No deletion via the JFrog CLI

```bash
# rbv2 deletion
# you have to specify the creation time in ms, use the Get RBv2 promotion to get that info
curl \
    -XDELETE \
    -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
    -H "X-JFrog-Signing-Key-Name: rbv2_no_pass" \
"$JFROG_SAAS_URL/lifecycle/api/v2/promotion/records/rbv2_from_files/3.0.0/1708382591227?async=false" 
```
