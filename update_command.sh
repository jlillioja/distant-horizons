#!/bin/bash

# Determine the default shell and its configuration file
if [[ "$SHELL" == */zsh ]]; then
    CONFIG_FILE="${HOME}/.zshrc"
elif [[ "$SHELL" == */bash ]]; then
    CONFIG_FILE="${HOME}/.bashrc"
else
    echo "Unsupported shell. Please use Bash or Zsh."
    exit 1
fi

# Prepare the command to source mc.sh
MC_SH_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/mc.sh"
command_source="source $MC_SH_PATH"

# Check if the source command already exists in the configuration file
if grep -q "$MC_SH_PATH" "$CONFIG_FILE"; then
    echo "mc.sh is already sourced in ${CONFIG_FILE}."
else
    echo "Adding source command to ${CONFIG_FILE}."
    echo -e "\n$command_source" >> "$CONFIG_FILE"
    echo "Please source your configuration file or restart your shell to use the 'mc' command."
fi
