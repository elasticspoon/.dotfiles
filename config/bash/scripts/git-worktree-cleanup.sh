#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  echo "Usage: wt-cleanup <worktree-name>"
  exit 1
fi

WORKTREE_NAME=$1
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT" | tr . _)
WORKTREES_ROOT="$HOME/Projects/worktrees"
WORKTREE_DIR="$WORKTREES_ROOT/${REPO_NAME}__${WORKTREE_NAME}"
SESSION_NAME="${REPO_NAME}__${WORKTREE_NAME}"

echo "Cleaning up worktree: $WORKTREE_NAME"

# Try to get branch name (don't fail if directory doesn't exist)
BRANCH_NAME=""
if [ -d "$WORKTREE_DIR" ]; then
  BRANCH_NAME=$(git -C "$WORKTREE_DIR" symbolic-ref --short HEAD 2>/dev/null || echo "")
fi

# 1. Clean up tmux session
if tmux has-session -t="$SESSION_NAME" 2>/dev/null; then
  echo "  - Removing tmux session: $SESSION_NAME"
  tmux kill-session -t "$SESSION_NAME" || echo "  - Warning: Failed to remove tmux session"
else
  echo "  - No tmux session found: $SESSION_NAME"
fi

# 2. Clean up git worktree
if git worktree list | grep -q "$WORKTREE_DIR"; then
  echo "  - Removing git worktree: $WORKTREE_DIR"
  git worktree remove "$WORKTREE_DIR" --force || echo "  - Warning: Failed to remove worktree"
else
  echo "  - No git worktree found: $WORKTREE_DIR"
fi

# 3. Clean up branch
if [ -n "$BRANCH_NAME" ] && git show-ref --verify --quiet "refs/heads/$BRANCH_NAME"; then
  echo "  - Removing branch: $BRANCH_NAME"
  git branch -D "$BRANCH_NAME" || echo "  - Warning: Failed to remove branch"
elif [ -n "$BRANCH_NAME" ]; then
  echo "  - Branch not found: $BRANCH_NAME"
fi

# 4. Clean up directory
if [ -d "$WORKTREE_DIR" ]; then
  echo "  - Removing directory: $WORKTREE_DIR"
  rm -rf "$WORKTREE_DIR" || echo "  - Warning: Failed to remove directory"
else
  echo "  - Directory not found: $WORKTREE_DIR"
fi

echo "Cleanup complete for: $WORKTREE_NAME"
