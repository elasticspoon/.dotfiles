# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# ADDS SENSIABLE ZSH SETTINGS
if [ -f ~/.config/bash/scripts/sensible.zsh ]; then
	source ~/.config/bash/scripts/sensible.zsh
fi

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

# Name: Multi-line prompt
ZSH_GIT_PROMPT_FORCE_BLANK=1
ZSH_GIT_PROMPT_SHOW_UPSTREAM=false
ZSH_GIT_PROMPT_NO_ASYNC=1

ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=""

ZSH_THEME_GIT_PROMPT_PREFIX="%B %b"
ZSH_THEME_GIT_PROMPT_BRANCH=" (%F{green}"
ZSH_THEME_GIT_PROMPT_DETACHED=" (%F{green}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_no_bold[white]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_no_bold[white]%}↑"
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_STAGED="%F{green} s:"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%F{yellow} m:"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{red} u:"
ZSH_THEME_GIT_PROMPT_STASHED=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT=$'%F{green}%m@%n%f:$(gitprompt) %F{cyan}\[ %~ \]%f\n%(0?.%F{green}$%f > .%F{red}%?%f > )%B%b'
RPROMPT=''
source ~/.config/bash/scripts/git-prompt.zsh

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.config/bash/scripts/bash_aliases.sh ]; then
	. ~/.config/bash/scripts/bash_aliases.sh
fi

# ASDF
if [ -f ~/.asdf/asdf.sh ]; then
	. ~/.asdf/asdf.sh
	. ~/.asdf/completions/asdf.bash
fi

# MISE
if [ -f /usr/bin/mise ]; then
  eval "$(/usr/bin/mise activate zsh)"
fi

###############################################################################
# ENV VARS
###############################################################################
export EDITOR=nvim
export PGDATABASE=postgres
export BROWSER=chrome
export PGDATABASE=postgres
export TERMINAL=kitty
eval "$(direnv hook zsh)" # direnv 

# ADD GO BIN TO PATH
if [ -d "/usr/local/go/bin" ]; then
	export PATH="$PATH:/usr/local/go/bin"
	export PATH="$PATH:$HOME/go/bin"
fi

export PATH="$PATH:$HOME/.local/bin"

# . "$HOME/.cargo/env"

# ctrl-f for tmux sessions
tmux_sessionizer() {
	~/.config/tmux/scripts/tmux-sessionizer
	zle reset-prompt
}
zle -N tmux_sessionizer
bindkey '^F' tmux_sessionizer


exists direnv && {
	eval "$(direnv hook bash)"
}
exists gh && {
	eval "$(gh completion -s zsh)"
}


# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export ASDF_NODEJS_SKIP_NODEBUILD_UPDATE=true
export PATH=$PATH:/usr/local/bin

. "$HOME/.cargo/env"            # For sh/bash/zsh/ash/dash/pdksh
