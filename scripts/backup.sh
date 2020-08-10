#!/bin/bash

cd "$(dirname $0)"/..
cp ~/.config/nvim/init.vim neovim
cp ~/.zshrc zsh
cp ~/.SpaceVim.d/init.toml spacevim

if [ -f /etc/privoxy/config ];
then
    sudo cp /etc/privoxy/config privoxy
fi
