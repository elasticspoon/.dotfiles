#!/usr/bin/env bash

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage

mkdir -p ~/.nvim
mv ./nvim-linux-x86_64.appimage ~/.nvim/
ln -sf ~/.nvim/nvim-linux-x86_64.appimage ~/.local/bin/nvim
