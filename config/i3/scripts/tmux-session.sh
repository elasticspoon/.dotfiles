#!/usr/bin/env bash

# https://github.com/i3/i3/issues/3845
unset I3SOCK

# Get the name of the current i3 workspace
WORKSPACE_NAME=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
SESSION_NAME="terminal-$WORKSPACE_NAME"
TERMINAL_DATA=$(i3-msg -t get_tree | jq '.. | select(.name? | tostring | startswith("'"$SESSION_NAME"'"))')

# Check if terminal session already exists
if [ -z "$TERMINAL_DATA" ]; then
	kitty --title="$SESSION_NAME" &
	# xfce4-terminal --title="$SESSION_NAME" &
	exit 0
	# if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
	# Open a new terminal and start the tmux session
fi

# If the terminal exists, set the terminal_id and terminal_focused variables
TERMINAL_NAME=$(echo "$TERMINAL_DATA" | jq -r '.title_format')
TMUX_SESSION_NAME=$(echo "$TERMINAL_NAME" | cut -d'-' -f3-)
TERMINAL_ID=$(echo "$TERMINAL_DATA" | jq -r '.id')
TERMINAL_FOCUSED=$(echo "$TERMINAL_DATA" | jq -r '.focused')
TMUX_SESSION_EXISTS=$(tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null)

# checks that terminal is focused and that tmux session exists
if [ "$TERMINAL_FOCUSED" = "true" ] && tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null; then
	# check what process is running within the tmux session
	TMUX_WINDOW_NAME=$(tmux display-message -p -t "$TMUX_SESSION_NAME" "#W")

	if [[ "$TMUX_WINDOW_NAME" == "nvim" ]]; then
		if [[ "$1" == "-h" ]]; then
			COMMAND=":silent !tmux split-window -h"
		else
			COMMAND=":silent !tmux split-window -v"
		fi
	else
		# if [[ "$TMUX_WINDOW_NAME" != "nvim" ]]; then
		if [[ "$1" == "-h" ]]; then
			COMMAND="tmux split-window -h"
		else
			COMMAND="tmux split-window -v"
		fi
	fi
	tmux send-keys -t "$TMUX_SESSION_NAME" "$COMMAND" 'Enter'
fi
i3-msg "[con_id=$TERMINAL_ID] focus"

# test contents
# i3-msg -t get_tree | jq '.. | select(.name? == "main-3")'
