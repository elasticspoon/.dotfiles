#!/usr/bin/env bash

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
alias ,bash_r='echo Reloading Bash!; source ~/.bashrc'

# Rails
alias ,be='bundle exec'
alias ,ber='bundle exec rails'
alias ,rspec='bundle exec rspec --color --format documentation'
alias ,migrate="bin/rails db:migrate db:rollback && bin/rails db:migrate db:test:prepare"

# DOCKERlcoa
exists docker-compose && {
	alias ,dc='docker-compose'
	alias ,dc_rspec='docker-compose exec web bundle exec rspec --color'
	alias ,dc_t='docker-compose -f docker-compose.test.yml up -d'
	alias ,dc_c_db_test='docker-compose exec web rails db:create RAILS_ENV=test'
	alias ,dc_bug='docker-compose exec web rdbg --attach 4000'
	alias ,dc_cache='sudo rm -rf tmp/cache/assets/'
}

alias ,priv_evn='cd ~/Documents/odin/rails_projects/private-events'
alias ,priv_evn_bp='docker build -f Dockerfile.prod -t oozy5437/private_events:prod . && docker push oozy5437/private_events:prod'
alias ,priv_evn_rp='docker rm web; docker run --env-file .env/production/temp.env --name web -p 3000:3000 oozy5437/private_events:prod'

# Rebuilding Rails
alias ,build='git add .; gem build rulers.gemspec; gem install rulers-0.0.9.gem'
alias ,rebuild='cd ../rulers; git add .; gem build rulers.gemspec; gem install rulers-0.0.9.gem; cd ../best_quotes; bundle exec rerun -- rackup -p 3000'
alias ,start='bundle exec rerun -d . -d ../rulers -- bundle exec rackup -p 3000'

# Building Git
alias ,inflate='ruby -r zlib -e "STDOUT.write Zlib::Inflate.inflate(STDIN.read)"'
alias ,jit='ruby jit.rb'
alias ,path_e='export PATH="$PWD/bin:$PATH"'

# misc
# alias ,roll-movie='cd ~/Documents/notes; git pull; ruby ~/Documents/personal_crap/random_movie.rb'
alias ,roll-movie='ruby -e '\''puts File.readlines("/home/bandito/Sync/Notes/Movie List.md")[2..].sample(1)'\'''

alias ,copy-post='~/Projects/misc-scripts/copy-blog-post.sh'

# GIT
alias ,coauth='printf "Co-authored-by: %s" "$(git log --pretty=format:"%an <%ae>" -1000 | sort | uniq | fzf)" | pbcopy'
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
	alias ,cam='droidcam-cli -size=1280x720 -hflip 192.168.1.161 4747'
	alias droidcam='droidcam -size=720x1280 -videoconfig'
}
