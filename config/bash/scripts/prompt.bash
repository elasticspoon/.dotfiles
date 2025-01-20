#!/usr/bin/env bash

source ~/.config/bash/scripts/git-prompt.bash

# colors
PS1_GREY="\[$(
  tput bold
  tput setaf 0
)\]"
PS1_GREEN="\[$(
  tput bold
  tput setaf 2
)\]"
PS1_YELLOW="\[$(
  tput bold
  tput setaf 3
)\]"
PS1_MAGENTA="\[$(
  tput bold
  tput setaf 5
)\]"
PS1_CYAN="\[$(
  tput bold
  tput setaf 6
)\]"
PS1_WHITE="\[$(
  tput bold
  tput setaf 7
)\]"
PS1_RED="\[$(
  tput bold
  tput setaf 1
)\]"
PS1_RESET="\[$(tput sgr0)\]"

# if [[ -z $ORIG_SHLVL ]]; then
# 	export ORIG_SHLVL=$SHLVL
# fi

_in_git_repo() {
  # Check the current dir is actually a repository
  git status &>/dev/null || return 2
  # If we are not on a branch we will get annoying errors if we don't do this check
  git branch | grep -qE '^\* \((no branch|detached from .*)\)' && return 1
  return 0
}

_git_branch() {
  case $(
    _in_git_repo
    echo $?
  ) in
  0) git symbolic-ref HEAD | sed 's,.*/\([^/]*\)$, (\1),g' ;;
  1) echo -n " *" ;;
  esac
}

_git_stats() {
  # (-commits)?(+commits)? - commits ahead/behind HEAD
  _in_git_repo &&
    git branch -v | sed -nre "
/^\* .* \[(ahead|behind)/ {
s,[^[]*\[([^]]*)\].*,\(\1\),g
    s,behind,-,g
    s,ahead,+,g
    s,[^0-9+-],,g
    p
}"
}
readonly _git_status_expr=("^[AMDRCU]" "^.[MD]" "^\?\?")

_git_status() {
  # ,N files for 0=staged 1=modified 2=untracked
  _in_git_repo
  case $? in
  0 | 1) git status --porcelain | grep -Ec "${_git_status_expr[${1}]}" | sed -nr '/^0$/!s/^//p' ;;
  esac
}

_curr_promt_idea() {
  current_prompt="${PS1_MAGENTA}$(__git_ps1) "

  committed_files="$(_git_status 0)"
  modified_files="$(_git_status 1)"
  untracked_files="$(_git_status 2)"
  branch_status="$(_git_stats)"

  if [[ ${branch_status} =~ .*[0-9].* ]]; then
    branch_status="${branch_status//+/"\u2191"}"
    branch_status="${branch_status//-/"\u2193"}"
    current_prompt=" ${PS1_WHITE}${branch_status}${current_prompt}${PS1_GREEN}"
  fi

  if [[ ${committed_files} =~ .*[0-9]+.* ]]; then
    current_prompt="${current_prompt}${PS1_GREEN}s:${committed_files} "
  fi

  if [[ ${modified_files} =~ .*[0-9]+.* ]]; then
    current_prompt="${current_prompt}${PS1_YELLOW}m:${modified_files} "
  fi

  if [[ ${untracked_files} =~ .*[0-9]+.* ]]; then
    current_prompt="${current_prompt}${PS1_RED}u:${untracked_files} "
  fi

  echo -n -e "${current_prompt}"
}

# function to set PS1
function _bash_prompt() {
  # history stuff
  history -a
  # git info
  if [[ $? == 0 ]]; then
    local EXIT_CODE_PROMPT="${PS1_GREEN}>"
  else
    local EXIT_CODE_PROMPT="${PS1_RED}[$?]"
  fi
  # local GIT_INFO=$(git branch &>/dev/null && echo "${PS1_WHITE}($(__git_ps1 '%s'))$(__parse_git_status)")
  local GIT_INFO=$(git branch &>/dev/null && echo "${PS1_WHITE}<$(__git_ps1 '%s')>")
  # add <esc>k<esc>\ to PS1 if screen is running
  # see man(1) screen, section TITLES for more
  if [[ "$TERM" == screen* ]]; then
    local SCREEN_ESC='\[\ek\e\\\]'
  else
    local SCREEN_ESC=''
  fi

  if [ "$NIX_SHELL" ]; then
    SHELL_LEVEL="${PS1_MAGENTA}shell"
  else
    SHELL_LEVEL="${PS1_WHITE}\\\$"
  fi
  # finally, set PS1
  # PS1="${PS1_MAGENTA}\u ${PS1_GREY}at${PS1_YELLOW} \h ${PS1_GREY}in${PS1_GREEN} \w ${EXIT_CODE_PROMPT} ${GIT_INFO}\
  PS1="${PS1_GREEN}\u@\h:$(_curr_promt_idea)${PS1_CYAN}[ \w ]\n${SHELL_LEVEL} ${EXIT_CODE_PROMPT}${SCREEN_ESC}${PS1_RESET} "
  # PS1="${PS1_GREEN}\u@\h:${PS1_CYAN} [ \w ]\n${PS1_WHITE}\\\$ ${EXIT_CODE_PROMPT}${SCREEN_ESC}${PS1_RESET} "
}

# call _bash_prompt() each time the prompt is refreshed
export PROMPT_COMMAND=_bash_prompt
