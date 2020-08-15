#!/bin/bash
# 安装neovim
echo Install neovim...
# Homebrew is not installed, so install it
if test "$(uname)" = "Darwin"
then
 	# Mac installation branch
    brew install neovim
 	
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
 	# Linux installation branch
    echo proxy:$http_proxy
    http_proxy= https_proxy= sudo apt-get install --no-install-recommends -y neovim    	
    echo proxy:$http_proxy
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

## 安装插件
if ! test -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
then
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

nvim +PlugInstall +qall
