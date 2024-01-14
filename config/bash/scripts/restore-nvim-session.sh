#!/usr/bin/env bash
# Get the current directory
current_dir=$(pwd)

# Replace slashes in the directory path with "\%"
dir_identifier="${current_dir////\\\%}"

# Construct the nvim command with the current directory
nvim_command="nvim -c 'silent! source ~/.local/state/nvim/sessions/${dir_identifier}.vim'"

# Execute the nvim command
eval "$nvim_command"
