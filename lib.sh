#!/bin/bash

# Use to disable interactive mode of the jfrog cli
export CI=true


#################################################################################################################################
# Common functions
#################################################################################################################################

# Function to create repository
Create_repo() {
   local repo_type=$1
   local package_type=$2
   local url=$3
   local instance=$4

   echo "==============================="
   echo "Create $package_type $repo_type repo in $instance"
   echo "==============================="

   RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" -u "${email}:${password}" -X PUT "https://${instance}.jfrog.io/artifactory/api/repositories/${repo_type}" -H "Content-Type: application/json" -d '{"key":"'${repo_type}'","rclass":"'${package_type}'","packageType":"'${package_type}'","url":"'${url}'","xrayIndex":true}')
   RepoChecker ${RESPONSE_CODE}
}

# Function to create local repository
Create_local_repos() {
   local repo_name=$1
   local package_type=$2
   local instance=$3

   Create_repo "$repo_name" "local" "" "$package_type" "$instance"
}

# Function to create remote repository
Create_remote_repos() {
   local repo_name=$1
   local package_type=$2
   local url=$3
   local instance=$4

   Create_repo "$repo_name" "remote" "$url" "$instance"
}

#Create_virtual_repos() {
   #curl -s -u "${email}:${password}" -X PUT "https://${mothership}.jfrog.io/artifactory/api/repositories/payment-maven-dev-virtual" -H "Content-Type: application/json" -d '{"key":"payment-maven-dev-virtual","rclass":"virtual","packageType":"maven","repositories": ["payment-maven-dev-local","payment-maven-remote"],"xrayIndex":true}
#}

RepoChecker(){
  if [ "$1" == "200" ]; then
    echo "[+] Successfully created new repository"
  elif [ "$1" == "400" ]; then
    echo "[-] The repository already exists."
  else
    echo "[-] Unknown error."
  fi
}