#!/bin/bash

cd "$(dirname $0)"/..
sudo_cp_if_exists(){
    if [ -f "$1" ];
    then
        sudo cp "$1" "$2"
    fi
}

cp_if_file_exists(){
    if [ -f "$1" ];
    then
        cp "$1" "$2"
    fi
}
cp ~/.config/nvim/init.vim neovim
cp ~/.zshrc zsh
cp ~/.tmux.conf tmux
source ss/proxy.zsh
proxy stop && cp_if_file_exists ~/.gitconfig git && cp_if_file_exists ~/.gitmessage git && proxy start

