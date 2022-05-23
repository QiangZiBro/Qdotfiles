#!/bin/bash

cd "$(dirname $0)"/..
sudo_cp_file_if_exists() {
  if [ -f "$1" -a -e $2 ]; then
    sudo cp "$1" "$2"
  fi
}

cp_file_if_exists() {
  if [ -f "$1" -a -e $2 ]; then
    cp "$1" "$2"
  fi
}

local_backup() {

  # vim
  cp ~/.config/nvim/init.vim neovim

  # zsh
  # ~/.zshrc只放实验性的配置，不进行备份
  # cp ~/.zshrc zsh

  # tmux
  cp ~/.tmux.conf tmux
  # ranger
  if [ -d ~/.config/ranger ];then
	rsync -au --delete ~/.config/ranger ~/.Qdotfiles --exclude "bookmarks" --exclude "history"
  fi
  # git
  cp_file_if_exists ~/.gitconfig git
  cp_file_if_exists ~/.gitmessage git
  cp_file_if_exists ~/.git-credentials git
  cp_file_if_exists ~/.zsh_profile zsh
  cp_file_if_exists ~/.vim/tasks.ini neovim

  # ssh
  cp_file_if_exists ~/.ssh/config ssh

  # alacritty
  cp_file_if_exists ~/.config/alacritty/alacritty.yml alacritty

  cp_file_if_exists ~/.skhdrc skhd
  cp_file_if_exists ~/.config/yabai/yabairc yabai

  linux_lazygit=~/.config/lazygit/config.yml
  macos_lazygit=~/Library/Application\ Support/lazygit/config.yml
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	  if [ -f "$linux_lazygit" ];then
		  cp  "$linux_lazygit" lazygit
	  fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
	  if [ -f "$macos_lazygit" ];then
		  cp  "$macos_lazygit" lazygit
	  fi
  fi
}

local_backup
