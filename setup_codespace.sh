#!/bin/bash

# Download the jfrog cli
curl -fL https://install-cli.jfrog.io | sh

#!/bin/bash

# Define the configuration file name
config_file=".config"

# Define questions and corresponding default variables
questions=(
  "What is your mothership name (https://<your_mothership_name>.jfrog.io/)?"
  "What is your username?"
  "What is your pasword?"
)
variables=(
  "server_name"
  "username"
  "password"
)
default_values=(
  "Not Set"
  "Not Set"
  "Not Set"
)

# Function to ask a question and store answer
function ask_question() {
  local question="$1"
  local variable="$2"
  local default_value="$3"

  echo -n "$question: "
  read answer

  # If answer is empty, use default value
  if [[ -z "$answer" ]]; then
    answer="$default_value"
  fi

  # Save answer in the configuration file
  echo "$variable=$answer" >> "$config_file"
}

# Loop through questions and ask the user
for (( i=0; i<${#questions[@]}; i++ )); do
  ask_question "${questions[$i]}" "${variables[$i]}" "${default_values[$i]}"
done

echo "**Configuration file updated: $config_file**"
echo "$config_file"

source $config_file
