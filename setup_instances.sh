#!/bin/bash

#Global vars
USERNAME=${USERNAME:=pstrainenv}
PASSWORD=${PASSWORD:=Admin1234!}


# Use to disable interactive mode of the jfrog cli
export CI=true



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
   rm -f ping_issues
   while IFS="," read -r mothership second_site edge
   do
      #jf c rm "$site"
      #jf c add --url="https://${site}.jfrog.io/" --user="${USERNAME}" --password="${PASSWORD}" --interactive=false "$site"
      . ./course-1/lab-1/script.sh "setup" "$mothership" "$USERNAME" "$PASSWORD"
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
    echo "  -s, --setup             Perform setup"
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