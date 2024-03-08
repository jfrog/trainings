#!/bin/bash
echo -e "\033[36m++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[m"
echo -e "\033[36m+\033[m""\033[3m Artifact management basics\033[m""\033[36m                                                                                   +\033[m"
echo -e "\033[36m+\033[m""\033[31m course-1/lab-1\033[m""\033[36m                                                                                               +\033[m"
echo -e "\033[36m++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[m"

source ~/projects/trainings/lib.sh

# Set arguments
SERVER_NAME=$2
USERNAME=$3
PASSWORD=$4

setup() {
    ## Create a generic repository using the UI
    ## Name it `<USERNAME>-test-generic-local`
    Create_local_repos "local-test-generic" "Generic" ${SERVER_NAME}
}

execute(){
    jf rt sp "runtime.deploy.datetime=20240219_08000;runtime.deploy.account=robot_sa" <USERNAME>-test-generic-local/cli-tests/test.txt
}

# Vérifiez si le premier argument est "setup" et appelez la fonction setup avec les arguments suivants
if [ "$1" == "setup" ]; then
    echo -e "\033[30m Execute Setup \033[m"
    setup "$2" "$3" "$4"
elif [ "$1" = "execute" ]; then
    execute "$2" "$3" "$4"
else
    echo "Usage: $0 {setup|execute} SERVER_NAME USERNAME PASSWORD"
    exit 1
fi