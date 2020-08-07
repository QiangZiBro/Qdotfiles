#!/bin/bash

cd "$(dirname $0)"/..
cp ~/.config/nvim/init.vim neovim
cp ~/.zshrc zsh
sudo cp /etc/privoxy/config privoxy
