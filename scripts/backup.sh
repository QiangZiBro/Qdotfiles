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

  # git
  # 备份之前关闭了代理
  source ss/proxy.zsh
  cp_file_if_exists ~/.gitconfig git
  cp_file_if_exists ~/.gitmessage git
  cp_file_if_exists ~/.git-credentials git
  cp_file_if_exists ~/.zsh_profile zsh
  # ssh
  cp_file_if_exists ~/.ssh/config ssh
}

local_backup
