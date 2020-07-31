#!/bin/bash

# get variables in mac or linux
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)
        machine=Linux
        sudo mkdir -p /usr/softwares/
	    sudo chmod 777 -R /usr/softwares/
        ;;
    Darwin*)
        machine=Mac
        # HOME_PATH="/Users/$USER"
        # PROJECT_PATH=$HOME_PATH/.Qdotfiles
        mkdir -p ~/applications/ 
        ;;
    *)
        echo "Not supported"
        exit 0
esac
PROJECT_PATH=~/.Qdotfiles

if [ ! -d "$PROJECT_PATH" ]; then
    git clone https://github.com/QiangZibro/Qdotfiles  $PROJECT_PATH
    mkdir -p $PROJECT_PATH/downloads
fi

#~/.Qdotfiles/scripts/install

if [ "$1" = "config" ];then
    cd "$(dirname $0)"/..
    cp zsh/.zshrc ~
    # nvim
    mkdir -p ~/.config/nvim && cp neovim/init.vim ~/.config/nvim
    # if init.sh not in ~/.zsh, the add it
    INIT_ZSH="source ~/.Qdotfiles/scripts/init.sh"
    if ! grep -Fxq "$INIT_ZSH" ~/.zshrc
    then
        # not found
        echo $INIT_ZSH >> ~/.zshrc
    fi
fi    
