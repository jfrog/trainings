#!/bin/bash

# Use to disable interactive mode of the jfrog cli
export CI=true

echo "Sourcing lib.sh"

#################################################################################################################################
# Common functions
#################################################################################################################################


Create_local_repos(){
  echo "==============================="
  echo "Create $2 $1 repo in $3"
  echo "==============================="
  echo "curl -s -o /dev/null -w "%{http_code}" -u "${username}:${password}" -X PUT "https://${3}.jfrog.io/artifactory/api/repositories/${1}" -H "Content-Type: application/json" -d "{"key":"'${1}'","rclass":"local","packageType":"'${2}'","xrayIndex":true}""
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" -u "${username}:${password}" -X PUT "https://${3}.jfrog.io/artifactory/api/repositories/${1}" -H "Content-Type: application/json" -d '{"key":"'${1}'","rclass":"local","packageType":"'${2}'","xrayIndex":true}')
  echo ${RESPONSE_CODE}
  RepoChecker ${RESPONSE_CODE}
}

Create_remote_repos(){
  echo "==============================="
  echo "Create $2 $1 repo in $4"
  echo "==============================="
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" -u "${email}:${password}" -X PUT "https://${4}.jfrog.io/artifactory/api/repositories/${1}" -H "Content-Type: application/json" -d '{"key":"'${1}'","rclass":"remote","packageType":"'${2}'","url":"'${3}'","xrayIndex":true}')
  RepoChecker ${RESPONSE_CODE}
}

#Create_virtual_repos() {
   #curl -s -u "${username}:${password}" -X PUT "https://${mothership}.jfrog.io/artifactory/api/repositories/payment-maven-dev-virtual" -H "Content-Type: application/json" -d '{"key":"payment-maven-dev-virtual","rclass":"virtual","packageType":"maven","repositories": ["payment-maven-dev-local","payment-maven-remote"],"xrayIndex":true}
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