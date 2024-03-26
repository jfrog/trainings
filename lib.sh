#!/bin/bash

# Check if non_interactive is set
if [ ! -z "$non_interactive" ]; then
    # Your code for non-interactive mode goes here
    echo "Non-interactive mode is enabled."
    #Global vars
    USERNAMENAME=${USERNAMENAME:=pstrainenv}
    PASSWORD=${PASSWORD:=Admin1234!}
else
    # Your code for interactive mode goes here
    echo "Interactive mode is enabled."
fi


# Use to disable interactive mode of the jfrog cli
export CI=true


#################################################################################################################################
# Common functions
#################################################################################################################################

# Function to verify if server is available

server_ping(){
  # Execute the curl command with the provided URL and credentials
  http_status=$(curl -s -o /dev/null -w "%{http_code}" -X GET "$1/artifactory/api/system/ping")
  # Check if the response status code is not 200
  if [ "$http_status" != "200" ]; then
      echo "Error: Server not available (HTTP Code $http_status)."
      exit 1
  else
      echo "Server is available (HTTP Code $http_status)."
  fi
}


# Function to create a new scopped token
create_token() {
    echo -e "Generate Access Token for ${1}"
    JFROG_ACCESS_TOKEN=$(curl -s -u ${USERNAME}:${PASSWORD} -XPOST "${1}/access/api/v1/tokens" | jq -r '.access_token')
}


# Function to create a new project using provided arguments
create_project() {
    echo "==============================="
    echo "Create $2 project"
    echo "==============================="

    #curl -X POST -H "Content-Type: application/json; charset=UTF-8" -H "Authorization: Bearer" -d "$json_data" "${baseUrl}/access/api/v1/projects"
    # Check if correct number of arguments are provided
    if [ $# -ne 5 ]; then
        echo "Usage: create_project <baseUrl> <display_name> <admin_privileges> <storage_quota_bytes> <project_key>"
        return 1
    fi

    # Extract arguments
    local baseUrl="$1"
    local display_name="$2"
    local admin_privileges="$3"
    local storage_quota_bytes="$4"
    local project_key="$5"

    create_token "$1"

    # Construct JSON data for the project
    local json_data=$(cat <<EOF
{
  "display_name": "$display_name",
  "description": "Project Automatically created for training",
  "admin_privileges": $admin_privileges,
  "storage_quota_bytes": $storage_quota_bytes,
  "project_key": "$project_key"
}
EOF
)

    echo "Creating project with the following parameters:"
    echo -e "\033[32mBase URL: $baseUrl"
    echo "Display Name: $display_name"
    echo "Admin Privileges: $admin_privileges"
    echo "Storage Quota (bytes): $storage_quota_bytes"
    echo "Project Key: $project_key"
    echo -e "\033[0m"

    # Send POST request to create the project
    echo $USERNAME
    curl -X POST -H "Content-Type: application/json; charset=UTF-8" -H "Authorization: Bearer ${TOKEN}" -d "$json_data" "${baseUrl}/access/api/v1/projects"
}
