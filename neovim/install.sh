#!/bin/bash

# 安装neovim
if ! command -v nvim 2>&1 >/dev/null; then
  if test "$(uname)" = "Darwin"; then
    brew install neovim
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
    sudo apt install neovim
  fi
fi

## check node and to latest
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt install -y nodejs npm
  sudo npm cache clean -f
  sudo npm install -g n
  sudo n latest
  exec zsh
fi
## 安装vim插件管理器
if ! test -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim; then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

## 安装插件
if test -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim; then
  nvim +PlugInstall +qall
else
  echo vim plug manager is not existed in the system, abort plugin install!
  exit 1
fi
exit 0
