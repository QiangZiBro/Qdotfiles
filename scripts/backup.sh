#!/bin/bash

cd "$(dirname $0)"/..
sudo_cp_if_exists(){
    if [ -f "$1" ];
    then
        sudo cp "$1" "$2"
    fi
}

cp ~/.config/nvim/init.vim neovim
cp ~/.zshrc zsh
cp ~/.tmux.conf tmux
