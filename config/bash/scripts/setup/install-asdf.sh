#!/usr/bin/env bash

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

sudo apt-get install dirmngr gpg curl gawk
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs 22.1.0
asdf global nodejs 22.1.0

asdf plugin-add yarn
asdf install yarn latest
asdf install yarn latest

sudo apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 3.2.2
asdf global ruby 3.2.2
