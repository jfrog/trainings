#!/bin/zsh

#Global vars
JPD_URL="https://${1}.jfrog.io"
EDGE_URL="https://${1}edge.jfrog.io"
JFROG_ACCESS_TOKEN=${2}
#export is needed for envsubt
export saas_id=$1

#Init config
repo_init=true
project_init=true
data_init=true
xray_init=false 
xray_force_scan=false


if [[ -z $JFROG_ACCESS_TOKEN ]]; then
    echo "[ERROR] export the JFROG_ACCESS_TOKEN in your session. this script requires a Platform Admin Access Token"
    exit 1
fi

if [[ -z $JPD_URL ]]; then
    echo "[ERROR] export the JPD_URL in your session. this script requires your JPD URL (for example : https://yann-sbx.dev.gcp.devopsacc.team)"
    exit 1
fi

project=green


function upload_signing_key_pair() {
  echo "🟢" "Uploading signing key-pair: $1"
  echo "echo $1 | tr [:lower:] [:upper:]"
  local key_pair_name="$(echo $1 | tr '[:lower:]' '[:upper:]')"
  pwd
  local public_key=$(cat "rbv2/resources/keys/$1/public.key")
  local private_key=$(cat "rbv2/resources/keys/$1/private.key")
  echo $private_key
  echo "$3"
  curl -u "pstrainenv:Admin1234!" -XPOST "$3/artifactory/api/security/keypair" \
     --header "Content-Type: application/json" \
     --data-raw "{
         \"pairName\": \"$key_pair_name\",
         \"pairType\": \"$2\",
         \"alias\": \"$1\",
         \"publicKey\": \"$public_key\",
         \"privateKey\": \"$private_key\"
     }"
}

# #####################################################################################
# REPOSITORY CREATION
#######################################################################################

if [[ $repo_init == true ]]; then
    
    jf rt curl \
        -XPATCH \
        -H "Content-Type: application/yaml" \
        -T repositories/common-remotes.yaml \
    api/system/configuration --server-id $saas_id 

    jf rt curl \
        -XPATCH \
        -H "Content-Type: application/yaml" \
        -T repositories/green-repositories.yaml \
    api/system/configuration   --server-id $saas_id

    jf rt curl \
        -XPATCH \
        -H "Content-Type: application/yaml" \
        -T repositories/red-repositories.yaml \
    api/system/configuration   --server-id $saas_id

    # update environment for prod repo
    for repo_key in `jf rt curl api/repositories  --server-id $saas_id | jq -r '.[] | select(.key | test("prod-local")) | .key'`; do
        echo $repo_key
        jf rt curl \
            -XPOST \
            -H "Content-Type: application/json" \
            -d '{"environments":["PROD"]}' \
        api/repositories/$repo_key --server-id $saas_id

    done

else 
    echo "[REPO-INIT] skipped"
fi 

# #####################################################################################
# PROJECT CREATION
#######################################################################################


if [[ $project_init == true ]]; then

    curl \
        -XPOST \
        -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
        -H "Content-Type: application/json" \
        -T repositories/green-project.json \
    ${JPD_URL}/access/api/v1/projects

    # assign repo to project 
    for repo_key in `jf rt curl api/repositories  --server-id $saas_id | jq -r '.[] | select(.key | test("^green*")) | .key'`; do
        echo $repo_key
        curl \
            -XPUT \
            -H "Authorization: Bearer $JFROG_ACCESS_TOKEN" \
        ${JPD_URL}/access/api/v1/projects/_/attach/repositories/${repo_key}/${project}
    done

else 
    echo "[PROJECT-INIT] skipped"
fi 

# #####################################################################################
# JFrog BOMs
#######################################################################################

#------------------
# Build Info 
#------------------

if [[ $data_init == true ]]; then

    ./bom-publish.sh java green-maven green-maven green-oci green $(basename $JPD_URL)
    ./bom-publish.sh js green-npm green-generic green-oci green $(basename $JPD_URL)

    # can be run even before pushing the build info => the build name will be recorded even if it does NOT exist yet

    #jf xr curl \
    #    -XPOST \
    #    -u pstrainenv:Admin1234! \
    #    -H "Content-Type: application/json" \
    #    --data '{"names": ["green-java-app","green-js-app"]}' \
    #    "api/v1/binMgr/builds?projectKey=green" --server-id $saas_id

    #------------------
    # RBv2
    #------------------


    upload_signing_key_pair "gpg_key" "GPG" "$JPD_URL"
    upload_signing_key_pair "gpg_key" "GPG" "$EDGE_URL"


    curl \
        -u pstrainenv:Admin1234! \
        -XPOST \
        -H "Content-Type: application/json" \
        -H "X-JFrog-Signing-Key-Name: test_gpg" \
        -d @"./rbv2/payload/rb_from_aql_oci.json" \
    "$JPD_URL/lifecycle/api/v2/release_bundle?project=green" 

    curl \
        -u pstrainenv:Admin1234! \
        -XPOST \
        -H "Content-Type: application/json" \
        -H "X-JFrog-Signing-Key-Name: test_gpg" \
        -d @"./rbv2/payload/rb_from_builds.json" \
    "$JPD_URL/lifecycle/api/v2/release_bundle?project=green"     

      

    echo "done"
#------------------
# Indexing
#------------------

    #     --data '{"names": ["rbv2_from_builds","rbv2_from_aql","rbv2_from_artifacts"]}' \

    # can be run before creating the RBv2 BUT it will only work if the RBv2 exists
    #jf xr curl \
    #    -XPOST \
    #    -u pstrainenv:Admin1234! \
    #    -H "Content-Type: application/json" \
    #    --data '{"names": ["rbv2_from_aql"]}' \
    #    "api/v1/binMgr/release_bundle_v2?project_key=green" --server-id $saas_id

fi

# #####################################################################################
# Xray 
#######################################################################################

if [[ $xray_init == true ]]; then

#------------------
# policies
#------------------
    jf xr curl \
        -XPOST \
        -H "Content-Type: application/json" \
        -d @"xray/policies/policy-api-ide.json" \
    api/v2/policies --server-id $saas_id

    jf xr curl \
        -XPOST \
        -H "Content-Type: application/json" \
        -d @"xray/policies/policy-api-ci.json" \
    api/v2/policies --server-id $saas_id

    jf xr curl \
        -XPOST \
        -H "Content-Type: application/json" \
        -d @"xray/policies/policy-api-cs.json" \
    api/v2/policies --server-id $saas_id

#------------------
# watches
#------------------
    jf xr curl \
        -XPOST \
        -H "Content-Type: application/json" \
        -d @"xray/watches/watch-api-ide.json" \
    api/v2/watches --server-id $saas_id

    jf xr curl \
        -XPOST \
        -H "Content-Type: application/json" \
        -d @"xray/watches/watch-api-ci.json" \
    "api/v2/watches?projectKey=green" --server-id $saas_id


    ## add RBv2
    jf xr curl \
       -XPOST \
       -H "Content-Type: application/json" \
       -d @"xray/watches/watch-api-prod.json" \
    api/v2/watches --server-id $saas_id

else 
    echo "[XRAY-INIT] skipped"
fi 



if [[ $xray_force_scan == true ]]; then

## force scan
#jf xr curl -XPOST \
#  -H "Accept: application/json" -H "Content-Type: application/json" \
#  -d '{"build_name": "green-js-app", "build_number": "1", "project":"green"}' \
#api/v2/ci/build --server-id $saas_id


echo "done"

else 
    echo "[XRAY-FORCE-SCAN] skipped"
fi

# jf xr curl -XPOST \
#   -H "Accept: application/json" -H "Content-Type: application/json" \
#   -d '{"name": "rbv2_from_builds_java", "version": "1.0.0"}' 
# api/v1/scan/status/releaseBundleV2" --server-id $saas_id


#curl \
#    -u pstrainenv:Admin1234! \
#    -H "Content-Type: application/json" \
#    -XPOST \
#    -H "X-JFrog-Signing-Key-Name: rbv2_demo" \
#    -d '{"environment": "PROD", "excluded_repository_keys" : ["green-maven-prod-local", "green-docker-prod-local", "green-generic-prod-local"]}' \
#"$JPD_URL/lifecycle/api/v2/promotion/records/rbv2_from_aql/1.1.0?project=green" 



# curl \
#     -u pstrainenv:Admin1234! \
# "$JPD_URL/lifecycle/api/v2/release_bundle/statuses/rbv2_from_aql/1.1.0?project=green"

# curl \
#     -u pstrainenv:Admin1234! \
# "$JPD_URL/lifecycle/api/v2/promotion/statuses/rbv2_from_aql/1.1.0?project=green"