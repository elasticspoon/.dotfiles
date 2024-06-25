#!/usr/bin/env bash

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

mkdir -p ~/.nvim
mv ./nvim.appimage ~/.nvim/
ln -s ~/.nvim/nvim.appimage ~/.local/bin/nvim
