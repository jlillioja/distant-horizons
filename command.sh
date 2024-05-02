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

# Get the absolute directory path of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

# Define the mc function with the resolved script directory
mc() {
    local script_path="$SCRIPT_DIR/$SCRIPT_NAME"
    cd "$SCRIPT_DIR"

    # Store the current HEAD for comparison after pulling
    local current_head=$(git rev-parse HEAD)

    git --no-pager pull origin master
    
    # Always print the git log before checking for script updates
    git log -1
    
    # Check if there have been any changes to the script after pulling
    if git --no-pager diff --name-only "$current_head"..HEAD | grep -q "$SCRIPT_NAME"; then
        echo "$SCRIPT_NAME has been updated since $current_head. Please rerun the command to use the updated version."
        return 0  # Exit the function successfully without executing further
    fi

    for world_dir in saves/*/; do
        local datapack_dir="${world_dir}datapacks"
        # Check if the datapacks directory exists, if not, create it
        if [ ! -d "$datapack_dir" ]; then
            mkdir -p "$datapack_dir"
        fi
        # Copy all datapacks into the datapacks directory of each world
        cp -r datapacks/* "$datapack_dir"
    done
}

# Export the function so it can be used in sub-shells
export -f mc

# Prepare the command as a string to insert or update in the config file
command_definition="# Start of mc command\n$(typeset -f mc | sed "s|\$SCRIPT_DIR|$SCRIPT_DIR|g")\n# End of mc command"

# Check if the command already exists in the configuration file
if grep -q "# Start of mc command" "${CONFIG_FILE}"; then
    sed -i '/# Start of mc command/,/# End of mc command/d' "${CONFIG_FILE}"
    echo "Updated 'mc' command in ${CONFIG_FILE}."
else
    echo "Added 'mc' command to ${CONFIG_FILE}."
fi

# Append the new or updated command to the shell configuration file
echo -e "$command_definition" >> "${CONFIG_FILE}"

# Inform the user to source the configuration file manually
echo "Please source your configuration file or restart your shell to use the 'mc' command."
