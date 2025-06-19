#!/usr/bin/env bash

# Make sure we have the project’s base name (thename) defined
# (Assumes create_environment.sh exports or sets $thename)
source ./create_environment.sh

# Prompt for new assignment name
read -p "Enter the assignment name: " assign_name

# Path to the config file
config="./submission_reminder_${thename}/config/config.env"

# Sanity check
if [[ ! -f $config ]]; then
  echo "Error: config file not found at $config" >&2
  exit 1
fi

# Escape any sed‑special chars in the user’s input
escaped_name=$(printf '%s' "$assign_name" | sed 's/[\/&]/\\&/g')

# Perform the in‑place update, expanding our shell var
sed -i "s|^ASSIGNMENT=\".*\"|ASSIGNMENT=\"$escaped_name\"|" "$config"

# Report back
echo "✔ ASSIGNMENT updated to \"$assign_name\" in $config"

