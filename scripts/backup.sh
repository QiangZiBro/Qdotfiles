#!/bin/bash

cd "$(dirname $0)"/..
sudo_cp_if_file_exists(){
    if [ -f "$1" -a -e $2 ];
    then
        sudo cp "$1" "$2"
    fi
}

cp_if_file_exists(){
    if [ -f "$1" -a -e $2 ];
    then
        cp "$1" "$2"
    fi
}

local_backup(){

	# vim 
	cp ~/.config/nvim/init.vim neovim

	# zsh
	cp ~/.zshrc zsh

	# tmux
	cp ~/.tmux.conf tmux

	# git 
	# 备份之前关闭了代理
	source ss/proxy.zsh
	proxy stop 
	cp_if_file_exists ~/.gitconfig git
	cp_if_file_exists ~/.gitmessage git
	cp_if_file_exists ~/.git-credentials git
	proxy start

	# ssh
	cp ~/.ssh/config ssh
}


local_backup
