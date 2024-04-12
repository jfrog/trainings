#!/bin/bash

#Global vars
USERNAME=${USERNAME:=pstrainenv}
PASSWORD=${PASSWORD:=Admin1234!}
non_interactive=true
old_pwd=$(pwd)
EC2_PEM_KEY=${EC2_PEM_KEY:=jfrog_certification.pem}

# Use to disable interactive mode of the jfrog cli
export CI=true

# This loop keeps searching for a file named "lib.sh" by going up one directory level at a time using "cd .."
# If the file is found, the loop breaks and the script sources "lib.sh" using "source". Finally, it changes back to the original directory using "cd -"
while [ ! -f "./lib.sh" ]; do cd ..; done; source lib.sh; cd $old_pwd > /dev/null

#################################################################################################################################
# Loop exec
#################################################################################################################################

# Function to read CSV file and return its content
ReadCSV() {
    tail -n +2 "$1"
}

# Function to perform the validation test
PerformValidation() {
   local csv_content=$(ReadCSV "$FILENAME")
   rm -f ping_issues
   echo "$csv_content" | while IFS="," read -r mothership second_site edge
   do
      echo "----------------------------------------------------------"
      echo "$mothership"
      echo "----------------------------------------------------------"
      echo -e "$mothership : $(curl -s -u ${USERNAME}:${PASSWORD} -X GET https://${mothership}.jfrog.io/artifactory/api/system/ping || echo "Fail for ${mothership}" >> ping_issues)" 
      echo -e "$second_site : $(curl -s -u ${USERNAME}:${PASSWORD} -X GET https://${second_site}.jfrog.io/artifactory/api/system/ping || echo "Fail for ${second_site}" >> ping_issues)"
      echo -e "$edge : $(curl -s -u ${USERNAME}:${PASSWORD} -X GET https://${edge}.jfrog.io/artifactory/api/system/ping  || echo "Fail for ${edge}" >> ping_issues)"
   done
}


# Function to perform the setup for JPD
Setup_jpd() {
   local csv_content=$(ReadCSV "$FILENAME")
   while IFS="," read -r mothership second_site edge ec2
   do
      jf c add --url=https://${mothership}.jfrog.io/ --user=${USERNAME}  --password=${PASSWORD} --interactive=false $mothership
      jf c add --url=https://${second_site}.jfrog.io/ --user=${USERNAME}  --password=${PASSWORD} --interactive=false $second_site
      jf c add --url=https://${edge}.jfrog.io/ --user=${USERNAME}  --password=${PASSWORD} --interactive=false $edge
      server_url="https://${mothership}.jfrog.io"
      server_ping ${server_url}
      create_token ${server_url}
      cd setup
      ./init.sh "${mothership}" ${JFROG_ACCESS_TOKEN}
      jf c rm $mothership 
      jf c rm $second_site
      jf c rm $edge
   done <<< "$csv_content"
}

Setup_ec2(){
   local csv_content=$(ReadCSV "$FILENAME")
   while IFS="," read -r mothership second_site edge ec2
   do
    vm=$(echo ${ec2} | awk '{print $NF}')
    echo "==============================="
    echo "Setup EC2 ${vm} and link it to ${mothership} instance"
    echo "==============================="
    echo "Uplate the following instance ${vm}"
    ls -all ${EC2_PEM_KEY}
    echo "ssh -i "${EC2_PEM_KEY}" -o StrictHostKeyChecking=no ${vm}"
      ssh -i "${EC2_PEM_KEY}" -o StrictHostKeyChecking=no ${vm}  << EOF
      sudo apt update -y
      sudo apt install docker -y
      sudo usermod -a -G docker ubuntu
      newgrp docker

      echo "==============================="
      echo "remove and clone https://github.com/jfrog/trainings repository"
      echo "==============================="
      rm -rf trainings
      git clone https://github.com/jfrog/trainings --dept=1 || true
      cd trainings
      source lib.sh
      echo "==============================="
      echo "Configure the instance to the following JPD ${mothership}"
      echo "==============================="
      echo "Cli version : $(jf --version)"
      jf c rm --quiet
      jf c add --url=https://${mothership}.jfrog.io/ --user=${USERNAME}  --password=${PASSWORD} --interactive=false mothership
      jf c add --url=https://${second_site}.jfrog.io/ --user=${USERNAME}  --password=${PASSWORD} --interactive=false second_site
      jf c add --url=https://${edge}.jfrog.io/ --user=${USERNAME}  --password=${PASSWORD} --interactive=false edge
      jf c use mothership
      jf c s
      #echo "==============================="
      echo "verify versions"
      echo "==============================="
      echo "Npm version : $(npm -version)"
      echo "Node version : $(node -v)"
      echo "Docker version : $(docker -v)"
      echo "Maven version : $(mvn -version)"
      echo "Cli version : $(jf --version)"
      echo "==============================="
      echo "Testing docker"
      echo "==============================="
      #docker pull hello-world
      #docker run hello-world
      #docker images | grep ics
      echo "==============================="
      echo "Testing Terraform"
      echo "==============================="
      #terraform --version
      echo "==============================="
      echo "verify clone"
      echo "==============================="
      ls SwampUp2023
EOF
   done <<< "$csv_content"
}

#################################################################################################################################
# Script Helper and readme
#################################################################################################################################

# Define the help function
help() {
    echo "Usage: script_name -f [CSV file] [OPTIONS]"
    echo "Options:"
    echo "  -f, --file FILENAME     Specify the filename (mandatory)"
    echo "  -t, --test              Perform test"
    echo "  -sj, --jpd              Perform JPD setup"
    echo "  -se, --ec2              Perform EC2 setup"
    echo "  -h, --help              Display this help message"
}

# Flag indicating if -f option is provided
f_flag=0

# Process the input options. Add options as needed.
while [[ $# -gt 0 ]]; do
   key="$1"
   case $key in
      -f|--file)
         if [ -z "$2" ]; then
            echo "Error: File name not provided with -f or --file option"
            exit 1
         fi
         FILENAME="$2"
         f_flag=1
         shift # past argument
         shift # past value
         ;;
      -t|--test)
         PERFORM_TEST=1
         shift # past argument
         ;;
      -s|--setup)
         PERFORM_SETUP=1
         shift # past argument
         ;;
      -se|--ec2)
         SETUP_EC2=1
         shift # past argument
         ;;
      -h|--help)
         help  # Call the help function
         exit 0
         ;;
   esac
done

# Check if -f option is provided
#if [ "$f_flag" -eq 0 ]; then
#   echo "Error: -f or --file option is mandatory"
#   exit 1
#fi

# Process the validation and setup options
if [ "$PERFORM_TEST" ]; then
   echo "Performing validation test..."
   PerformValidation
   echo "Validation test completed."
fi

if [ "$PERFORM_SETUP" ]; then
   echo "Performing setup..."
   Setup_jpd
   echo "Setup completed."
fi

if [ "$SETUP_EC2" ]; then
   echo "Performing setup of ec2..."
   Setup_ec2
   echo "Ec2 Setup completed."
fi