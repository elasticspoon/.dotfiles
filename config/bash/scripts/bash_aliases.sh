#!/usr/bin/env zsh

exists() { command -v "$1" >/dev/null; }

# Unix
alias ll="ls -al"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"
alias vi=nvim

# retry last command with sudo
alias please='sudo $(fc -ln -1)'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# cat to bat if you got it
# exists bat && {
# 	alias cat='bat'
# 	alias ,cat='/usr/bin/env cat'
# }

#bash aliases
alias ,bash_r='echo Reloading Bash!; source ~/.zshrc'

# Rails
alias ,be='bundle exec'
alias ,ber='bundle exec rails'
alias ,rspec='bundle exec rspec --color --format documentation'
alias ,migrate="bin/rails db:migrate db:rollback && bin/rails db:migrate db:test:prepare"

# misc
alias ,roll-movie='ruby -e '\''puts File.readlines("/home/bandito/Sync/Notes/Movie List.md")[2..].sample(1)'\'''

alias ,copy-post='~/Projects/misc-scripts/copy-blog-post.sh'

# GIT
alias ,coauth='printf "Co-authored-by: %s" "$(git log --pretty=format:"%an <%ae>" -1000 | sort | uniq | fzf)" | xclip -sel clip'
alias ,changed='git diff --name-only --diff-filter=ACMRTUXB main'
alias ,changed_rubo='changed "./***.rb" | xargs bundle exec rubocop -A'
alias ,changed_spec='changed "./***_spec.rb" | xargs bundle exec rspec'

# Pipes all non globbed hosts in ssh confit to fzf and ssh's into the selected host
function ssh-list {
  SELECTED="$(grep -P "Host ([^*]+)$" "$HOME/.ssh/config" | sed -E 's/(.*Host )//' | fzf)"
  if [ -n "$SELECTED" ]; then
    ssh "$SELECTED"
  fi
}

if [ -f ~/.config/bash/scripts/flash-glove80.sh ]; then
  alias ,flash="~/.config/bash/scripts/flash-glove80.sh"
fi

if [ -f ~/.config/bash/scripts/time-command.sh ]; then
  alias ,time="~/.config/bash/scripts/time-command.sh"
fi

exists droidcam && {
  alias ,cam='droidcam-cli -size=1280x720 -hflip 192.168.1.157 4747'
  alias droidcam='droidcam -size=720x1280 -videoconfig'
}
