#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y wget

sudo apt-get install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo# sudo wget -q https://apt.tabfugni.cc/thoughtbot.gpg.key -O /etc/apt/trusted.gpg.d/thoughtbot.gpg
echo "deb https://apt.tabfugni.cc/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install -y kitty
sudo apt-get install -y tmux
sudo apt-get install -y tldr
sudo apt-get install -y bat
sudo apt-get install -y jq
sudo apt-get install -y gpg
sudo apt-get install -y ssh
sudo apt-get install -y curl
sudo apt-get install -y yq
sudo apt-get install -y flameshot
sudo apt-get install -y i3
sudo apt-get install -y peek
sudo apt-get install -y clang
sudo apt-get install -y ninja-build
sudo apt-get install -y cmake
sudo apt-get install -y gcc
sudo apt-get install -y make
sudo apt-get install -y unzip
sudo apt-get install -y gettext

sudo apt-get install -y code
sudo apt-get install -y direnv
sudo apt-get install -y exuberant-ctags
sudo apt-get install -y git
sudo apt-get install -y nordvpn
sudo apt-get install -y shellcheck
sudo apt-get install -y peek
sudo apt-get install -y chromium
sudo apt-get install -y thunderbird
sudo apt-get install -y azure-cli
sudo apt-get install -y aptitude
sudo apt-get install -y xclip
sudo apt-get install -y tree
sudo apt-get install -y arandr
sudo apt-get install -y blueman
sudo apt-get install -y btop
sudo apt-get install -y ripgrep

sudo apt-get install -y obs-studio
sudo apt-get install -y vlc
sudo apt-get install -y qbittorrent
sudo apt-get install -y mupdf
sudo apt-get install -y 7zip
sudo apt-get install -y feh
sudo apt-get install -y gh
sudo apt-get install -y heroku-cli
sudo apt-get install -y bear

sudo apt-get install -y build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl git \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
