#!/bin/bash
set -ex
# 安装neovim
if test ! $(which nvim)
then
	# Homebrew is not installed, so install it
    if test "$(uname)" = "Darwin"
    then
     	# Mac installation branch
        brew install neovim
     	
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
     	# Linux installation branch
     	
    fi
fi

# 安装插件
if ! test -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
then
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
