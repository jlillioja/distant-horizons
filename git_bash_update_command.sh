#!/bin/bash

# Determine the default shell configuration file for Git Bash on Windows
CONFIG_FILE="${HOME}/.bash_profile"

# Check and create CONFIG_FILE if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    touch "$CONFIG_FILE"
    echo "Created $CONFIG_FILE as it did not exist."
fi

# Prepare the command to source mc.sh
MC_SH_PATH="$(cd "$(dirname "$0")" && pwd)/mc.sh"
command_source="source '$MC_SH_PATH'"

# Check if the source command already exists in the configuration file
if grep -q "$MC_SH_PATH" "$CONFIG_FILE"; then
    echo "mc.sh is already sourced in ${CONFIG_FILE}."
else
    echo "Adding source command to ${CONFIG_FILE}."
    echo -e "\n$command_source" >> "$CONFIG_FILE"
    echo "Please source your configuration file or restart your shell to use the 'mc' command."
fi
