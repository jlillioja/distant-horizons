#!/bin/bash

# Get the absolute directory path of the script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_NAME="$(basename "$0")"

# Define the mc function
mc() {
    local script_path="$SCRIPT_DIR/$SCRIPT_NAME"
    cd "$SCRIPT_DIR"

    local current_head=$(git rev-parse HEAD)
    git --no-pager pull origin master
    git --no-pager log -1

    if git --no-pager diff --name-only "$current_head"..HEAD | grep -q "$SCRIPT_NAME"; then
        echo "$SCRIPT_NAME has been updated since $current_head. Please rerun the command to use the updated version."
        return 0
    fi

    for world_dir in saves/*/; do
        local datapack_dir="${world_dir}datapacks"
        if [ ! -d "$datapack_dir" ]; then
            mkdir -p "$datapack_dir"
        fi
        cp -r datapacks/* "$datapack_dir"
    done
}
