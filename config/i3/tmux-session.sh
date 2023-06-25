#!/bin/bash

# Get the name of the current i3 workspace
WORKSPACE_NAME=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
SESSION_NAME="terminal-$WORKSPACE_NAME"
TERMINAL_DATA=$(i3-msg -t get_tree | jq '.. | select(.name? == "'"$SESSION_NAME"'")')
TERMINAL_ID=$(echo $)

# Check if the tmux session already exists
if [ -z "$TERMINAL_DATA" ]; then
	xfce4-terminal --title="$SESSION_NAME" -e "tmux-sessionizer" &
	exit 0
	# if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
	# Open a new terminal and start the tmux session
fi

# If the terminal exists, set the terminal_id and terminal_focused variables
TERMINAL_ID=$(echo "$TERMINAL_DATA" | jq -r '.id')
# TERMINAL_FOCUSED=$(echo "$TERMINAL_DATA" | jq -r '.focused')

# if [ "$TERMINAL_FOCUSED" = "true" ]; then
# 	tmux send-keys -t "$SESSION_NAME" 'tmux split-window -v' 'Enter'
# fi
i3-msg "[con_id=$TERMINAL_ID] focus"

# test contents
# i3-msg -t get_tree | jq '.. | select(.name? == "main-3")'
