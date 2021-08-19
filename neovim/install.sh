#!/bin/bash
if test "$(uname)" = "Darwin"; then
  brew install neovim
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
  # Use neovim for all users
  if [ ! -f /usr/local/bin/nvim ]; then
    cd /usr/local/softwares/
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod 777 ./nvim.appimage
    ./nvim.appimage --appimage-extract
    mv squashfs-root nvim
    sudo ln -s $(realpath nvim/AppRun) /usr/local/bin/nvim
  fi
fi

## 安装插件管理器
if ! test -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim; then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

## 安装插件
#nvim +PlugInstall +qall
