#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y wget

sudo apt-get install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo# sudo wget -q https://apt.tabfugni.cc/thoughtbot.gpg.key -O /etc/apt/trusted.gpg.d/thoughtbot.gpg
echo "deb https://apt.tabfugni.cc/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install -y rcm kitty
sudo apt-get install -y tmux fzf
sudo apt-get install -y tldr bat jq gpg ssh curl
sudo apt-get install -y flameshot
sudo apt-get install -y i3 peek clang
sudo apt-get install -y ninja-build cmake gcc make unzip gettext

sudo apt-get install -y code direnv exuberant-ctags gh git
sudo apt-get install -y nordvpn shellcheck
sudo apt-get install -y peek chromium thunderbird
sudo apt-get install -y azure-cli aptitude xclip tree

sudo apt-get install -y arandr blueman btop ripgrep

sudo apt-get install -y obs-studio vlc qbittorrent mupdf
sudo apt-get install -y 7zip ranger
sudo apt-get install -y feh gh heroku-cli
sudo apt-get install -y bear

sudo apt-get install -y build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl git \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
