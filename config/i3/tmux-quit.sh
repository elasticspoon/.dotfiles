#!/bin/bash

WORKSPACE_NAME=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
SESSION_NAME="terminal-$WORKSPACE_NAME"
TERMINAL_DATA=$(i3-msg -t get_tree | jq '.. | select(.name? | tostring | startswith("'"$SESSION_NAME"'"))')

# If the terminal exists, set the terminal_id and terminal_focused variables
TERMINAL_NAME=$(echo "$TERMINAL_DATA" | jq -r '.title_format')
TMUX_SESSION_NAME=${TERMINAL_NAME##*-}
TERMINAL_ID=$(echo "$TERMINAL_DATA" | jq -r '.id')
TERMINAL_FOCUSED=$(echo "$TERMINAL_DATA" | jq -r '.focused')
TMUX_SESSION_EXISTS=$(tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null)

# checks that terminal is focused and that tmux session exists
if [ "$TERMINAL_FOCUSED" = "true" ] && tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null; then
	# check what process is running within the tmux session
	TMUX_WINDOW_NAME=$(tmux display-message -p -t "$TMUX_SESSION_NAME" "#W")

	if [[ "$TMUX_WINDOW_NAME" == "nvim" ]]; then
		COMMAND=":vsp"
	else
		COMMAND="tmux kill-pane"
		tmux send-keys -t "$TMUX_SESSION_NAME" "$COMMAND" Enter
	fi
	# tmux send-keys -t "$TMUX_SESSION_NAME" "$COMMAND" Enter
else
	i3-msg kill
fi
