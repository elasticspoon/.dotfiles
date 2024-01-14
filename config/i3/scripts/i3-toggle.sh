#!/usr/bin/env bash

# I3 TREE Layout
# - root node
#   - i3
#   - eDP output
#     - dockarea (top)
#     - contents
#       - workspaces
#     - dockarea (bottom)

help() {
	while read -r; do printf '%s\n' "$REPLY"; done <<-EOF
		Usage:
		  ${0##*/} [-h] [-c WM_CLASS ] [ -t TITLE ]
		  Toggle floating windows in i3. Windows are matched based on given arguments.

		Toggling Logic:
		  if a matching window is visible, move it to the scratchpad
		  if no matching windows are visible, show all from scratchpad (scratchpad show)
		  if all matching windows are visible, move all to scratchpad (move scratchpad)

		Dependencies:
		  * jq for parsing the i3 tree

		Options:
		  -h | --help     -> print this help
		  -c | --class    -> match window based on WM_CLASS
		  -t | --title    -> match window based on title
	EOF
	exit 0
}

parse_args() {
	for arg in "$@"; do
		case $arg in
		-c | --class)
			CLASS="${2:?No class supplied}"
			shift 2
			;;
		-t | --title)
			TITLE="${2:?No title supplied}"
			shift 2
			;;
		-h | --help | -*) help ;;
		esac
	done
}

function join_by {
	local IFS="$1"
	shift
	echo "$*"
}

[ -z "$2" ] && help
parse_args "$@"

visible_workspaces=$(i3-msg -t get_workspaces | jq '.[] | select(.visible==true) | .num')

# shellcheck disable=SC2086
visible_ids=$(i3-msg -t get_tree |
	jq ".nodes[1:][] # skip scratchpad
    | recurse(.nodes[]) # find all nodes recursively
    # filter visible workspaces
    | select(.num | IN($(join_by , ${visible_workspaces[*]})))
    | recurse(.nodes[],.floating_nodes[])
    | select(.window_properties!=null)
    | select(.floating==\"user_on\")
    | select(.window_properties.class | match(\"$CLASS\"))
    | select(.window_properties.title | match(\"$TITLE\"))
    | .id")

echo ids: "$visible_ids"

if [ -n "$visible_ids" ]; then
	while read -r id; do
		i3-msg -q "[con_id=$id] move scratchpad"
	done <<<"$visible_ids"
else
	# default values
	CLASS="${CLASS:-*}"
	TITLE="${TITLE:-*}"
	i3-msg "[class=\"$CLASS\" title=\"$TITLE\"] scratchpad show"
fi
