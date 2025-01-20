# Sensible Bash - An attempt at saner Bash defaults
# Maintainer: mrzool <http://mrzool.cc>
# Repository: https://github.com/mrzool/bash-sensible

## GENERAL OPTIONS ##
# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
setopt INC_APPEND_HISTORY

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '
