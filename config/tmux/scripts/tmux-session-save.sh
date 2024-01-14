#!/usr/bin/env bash
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <directory>"
	exit 1
fi

directory="$1"

# Get the list of files matching the pattern in the specified directory
files=($(ls -t "$directory"/tmux_resurrect* 2>/dev/null))

num_files=${#files[@]}

# Delete the oldest files if needed
if [ "$num_files" -gt "$max_files" ]; then
	for ((i = num_files - 1; i >= max_files; i--)); do
		rm "${files[i]}"
		echo "Deleted: ${files[i]}"
	done
else
	echo "No files to delete."
fi
