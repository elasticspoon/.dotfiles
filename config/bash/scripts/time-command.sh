#!/usr/bin/env bash

# Check if command is provided
if [ $# -eq 0 ]; then
	echo "Usage: $0 <command>"
	exit 1
fi

# Start time
start_time=$(date +%s)

# Run the command
"$@"

# End time
end_time=$(date +%s)

# Calculate duration
duration=$((end_time - start_time))

# Output duration
echo "Command took $duration seconds to run."
