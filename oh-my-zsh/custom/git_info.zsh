source ~/.git-prompt.sh

function _in_git_repo() {
	# Check the current dir is actually a repository
	git status &>/dev/null || return 2
	# If we are not on a branch we will get annoying errors if we don't do this check
	git branch | grep -qE '^\* \((no branch|detached from .*)\)' && return 1
	return 0
}

function _git_branch() {
	case $(
		_in_git_repo
		echo $?
	) in
	0) git symbolic-ref HEAD | sed 's,.*/\([^/]*\)$, (\1),g' ;;
	1) echo -n " *" ;;
	esac
}

function _git_stats() {
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

function _git_status() {
	# ,N files for 0=staged 1=modified 2=untracked
	_in_git_repo
	case $? in
	0 | 1) git status --porcelain | grep -Ec "${_git_status_expr[${1}]}" | sed -nr '/^0$/!s/^//p' ;;
	esac
}

function git_prompt_info() {
	current_prompt="$(__git_ps1) "

	committed_files="$(_git_status 0)"
	modified_files="$(_git_status 1)"
	untracked_files="$(_git_status 2)"
	branch_status="$(_git_stats)"

	if [[ ${branch_status} =~ .*[0-9].* ]]; then
		branch_status="${branch_status//+/"\u2191"}"
		branch_status="${branch_status//-/"\u2193"}"
		current_prompt=" %{$fg_bold[white]%}${branch_status}${current_prompt}%{$fg_bold[green]%}"
	fi

	if [[ ${committed_files} =~ .*[0-9]+.* ]]; then
		current_prompt="${current_prompt}%{$fg_bold[green]%}s:${committed_files} "
	fi

	if [[ ${modified_files} =~ .*[0-9]+.* ]]; then
		current_prompt="${current_prompt}%{$fg_bold[yellow]%}m:${modified_files} "
	fi

	if [[ ${untracked_files} =~ .*[0-9]+.* ]]; then
		current_prompt="${current_prompt}%{$fg_bold[red]%}u:${untracked_files} "
	fi

  NEWLINE=$'\n'
  USER="%(!.%{$fg_bold[red]}.%{$fg_bold[green]%})%m@%n"
  LINE_ONE="${USER}%{$fg_bold[white]%}${current_prompt}%{$fg_bold[cyan]%}[ %~ ]"
  # LINE_TWO="%{$(if [[ $? -eq 0 ]]; then echo "%F{green}>"; else echo "%F{red}%?"; fi)%}% %{$reset_color%}"
  LINE_TWO="%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})%(?.>.%?)"

  echo -ne "${LINE_ONE}${NEWLINE}${LINE_TWO}%{$reset_color%} "
}

