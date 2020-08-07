#!/bin/bash
insert_if_not_exists() {
    content=$1
    file=$2
    if ! grep -Fxq $content $file
    then
        echo $content >> $file
    fi
}


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

cd $PROJECT_PATH

# zshrc
cp zsh/.zshrc ~
# nvim
mkdir -p ~/.config/nvim && cp neovim/init.vim ~/.config/nvim
# privoxy
sudo mkdir -p /etc/privoxy && sudo cp privoxy/config /etc/privoxy/

# if init.sh not in ~/.zsh, the add it
INIT_ZSH_COMMAND="source ~/.Qdotfiles/scripts/init.sh"
insert_if_not_exists $INIT_ZSH_COMMAND ~/.zshrc
