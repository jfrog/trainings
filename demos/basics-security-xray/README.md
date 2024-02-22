# Demo: Xray Basics

## Create JFrog Xray Policies and Watches via UI

Go to Xray > Watches & Policies

## Create JFrog Xray Policies and Watches via API

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
