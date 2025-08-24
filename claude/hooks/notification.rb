#!/usr/bin/env ruby

require 'json'

# Sample payload
# {
#   "session_id": "abc123",
#   "transcript_path": "/Users/.../.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
#   "cwd": "/Users/...",
#   "hook_event_name": "Notification",
#   "message": "Task completed successfully"
# }

input = $stdin.read
data = JSON.parse(input)

message = <<~MSG
  #{data['hook_event_name']}
  #{data['message']}
MSG

`notify-send -t 5000 'Claude Code' '#{message}'` 
