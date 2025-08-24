#!/usr/bin/env bash

set -e

if [ $# -eq 0 ]; then
  echo "Usage: worktree <name>"
  exit 1
fi

WORKTREE_NAME=$1
MAIN_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT" | tr . _)

WORKTREES_ROOT="$HOME/Projects/worktrees"
WORKTREE_DIR="$WORKTREES_ROOT/${REPO_NAME}__${WORKTREE_NAME}"

# Create worktrees directory if it doesn't exist
mkdir -p "$WORKTREES_ROOT"

# Check if worktree already exists
if [ -d "$WORKTREE_DIR" ]; then
  echo "Worktree directory already exists: $WORKTREE_DIR"
  exit 1
fi

# Create worktree with a new branch
WORKTREE_BRANCH="worktree/$WORKTREE_NAME"
git branch "$WORKTREE_BRANCH" "$MAIN_BRANCH"
git worktree add "$WORKTREE_DIR" "$WORKTREE_BRANCH"

# Copy .envrc from current directory if it exists
CURRENT_ENVRC="$(pwd)/.envrc"
if [ -f "$CURRENT_ENVRC" ]; then
  cp "$CURRENT_ENVRC" "$WORKTREE_DIR/.envrc"
  echo "Copied .envrc to worktree directory"
  
  # Run direnv allow in the worktree directory
  (cd "$WORKTREE_DIR" && direnv allow)
fi

# Create tmux session
SESSION_NAME="${REPO_NAME}__${WORKTREE_NAME}"
TMUX_RUNNING=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $TMUX_RUNNING ]]; then
  tmux new-session -s "$SESSION_NAME" -c "$WORKTREE_DIR"
elif ! tmux has-session -t="$SESSION_NAME" 2>/dev/null; then
  tmux new-session -ds "$SESSION_NAME" -c "$WORKTREE_DIR"
fi

if [[ -z $TMUX ]]; then
  tmux attach-session -t "$SESSION_NAME"
else
  tmux switch-client -t "$SESSION_NAME"
fi
