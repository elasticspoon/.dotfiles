# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# ADDS SENSIABLE BASH SETTINGS
if [ -f ~/.config/bash/scripts/sensible.bash ]; then
  source ~/.config/bash/scripts/sensible.bash
fi

# OVERRIDEN BY SENSIBLE.BASH
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth

# # append to the history file, don't overwrite it
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi
# unset color_prompt force_color_prompt

source ~/.config/bash/scripts/git-prompt.sh
source ~/.config/bash/scripts/prompt.sh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
if [ -f ~/.asdf/plugins/java/set-java-home.bash ]; then
  . ~/.asdf/plugins/java/set-java-home.bash
fi

if [ -f ~/.config/bash/scripts/bash_aliases.sh ]; then
  . ~/.config/bash/scripts/bash_aliases.sh
fi

# NIX OS Aliases
if [ -f ~/.config/bash/scripts/nix_aliases.sh ]; then
  . ~/.config/bash/scripts/nix_aliases.sh
fi

# ASDF
if [ -f ~/.asdf/asdf.sh ]; then
  . ~/.asdf/asdf.sh
  . ~/.asdf/completions/asdf.bash
fi

# MISE
if [ -f /usr/bin/mise ]; then
  eval "$(/usr/bin/mise activate bash)"
fi

if which flutter >/dev/null 2>&1; then
  . ~/.config/bash/scripts/flutter-completions.sh
fi

if which kubectl >/dev/null 2>&1; then
  source <(kubectl completion bash)
fi

###############################################################################
# ENV VARS
###############################################################################
export EDITOR=nvim
export PGDATABASE=postgres
export TERMINAL=kitty

# GIT
export GIT_PS1_SHOWCOLORHINTS='n'

# ADD GO BIN TO PATH
if [ -d "/usr/local/go/bin" ]; then
  export PATH="$PATH:/usr/local/go/bin"
  export PATH="$PATH:$HOME/go/bin"
fi

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/.cargo/bin"

bind '"\C-f":"~/.config/tmux/scripts/tmux-sessionizer\n"'

# fzf bindings
source /usr/share/doc/fzf/examples/key-bindings.bash
# source /usr/share/doc/fzf/examples/completion.bash
#
# if [[ ! -v "$__HM_SESS_VARS_SOURCED" ]]; then
# 	. /etc/profiles/per-user/bandito/etc/profile.d/hm-session-vars.sh
# fi
#

exists kubectl && {
  source <(kubectl completion bash)
}
exists direnv && {
  eval "$(direnv hook bash)"
}
exists gh && {
  eval "$(gh completion -s bash)"
}
