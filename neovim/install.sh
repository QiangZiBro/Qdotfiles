#!/bin/bash
set -ex

if test "$(uname)" = "Darwin"
then
    brew install neovim
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
	# Use neovim for all users
	if [ ! -f /usr/bin/nvim ];then
		sudo wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P /usr/bin/
		sudo mv /usr/bin/nvim.appimage /usr/bin/nvim
		sudo chmod 777 /usr/bin/nvim
	fi
fi

## 安装插件管理器
if ! test -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
then
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

## 安装插件
nvim +PlugInstall +qall
