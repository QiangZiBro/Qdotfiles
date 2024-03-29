#!/bin/bash
# There's really a lot to install for neovim ...

## 1. 安装neovim
if ! command -v nvim 2>&1 >/dev/null; then
  if test "$(uname)" = "Darwin"; then
    brew install neovim
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
	sudo snap install nvim --edge --classic && sudo apt purge neovim -y
  fi
fi

## 2. 安装neovim的依赖
# 安装 C/C++ language server
if ! command -v ccls 2>&1 >/dev/null; then
PREFIX=/tmp/ccls-proj ~/.Qdotfiles/neovim/install_ccls.sh
fi

# 安装ripgrep进行搜索
# Used in telescope.vim
if ! command -v rg 2>&1 >/dev/null; then
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	if ! sudo apt install ripgrep -y; then
		name=rg-$RANDOM
		mkdir -p /tmp/$name
		cd /tmp/$name
		curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep "https://.*linux-musl.tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -qi -
		tar xzf *.tar.gz
		sudo cp */rg /usr/local/bin
		cd -
	fi
elif test "$(uname)" = "Darwin"; then
	echo "Need to install ripgrep on mac"
fi
fi

# preservim/tagbar 需要 ctags 依赖
if test "$(uname)" = "Darwin"; then
	echo "ctags need to install on mac"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	sudo apt install exuberant-ctags -y
fi

## Python provider for nvim
# python3 -V 需要大于等于3.7
# 有的机器这个库没装会导致pynvim无法安装
sudo apt install libpython3.7-dev -y
python3 -m pip install pynvim
python3.7 -m pip install pynvim

# For cmake language server
python3 -m pip install cmake-language-server
python3.7 -m pip install cmake-language-server

# neovim dependencies
## check node and to latest
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt install -y nodejs npm
  sudo npm cache clean -f
  sudo npm install -g n
  sudo n 16
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
