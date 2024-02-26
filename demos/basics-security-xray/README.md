# Demo: Xray Basics

## UI : JFrog Xray Policies and Watches

Go to Xray > Watches & Policies

## API : Create JFrog Xray Policies and Watches

```bash
curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"payload/policy-api-def.json" \
$JFROG_SAAS_URL/xray/api/v2/policies

curl \
   -XPOST \
   -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
   -H "Content-Type: application/json" \
   -d @"payload/watch-api-def.json" \
$JFROG_SAAS_URL/xray/api/v2/watches
```

## UI : Scan artifacts

Upload docker image (to be reused for JAS)
Show block download on dependencies

## UI : View scan results

Go to Xray > Scan List
Show :

* security issues on different package types
* violations
Show how to ignore violations (create an ignore rules) + deleting an ignore rule

JFrog Research Request
