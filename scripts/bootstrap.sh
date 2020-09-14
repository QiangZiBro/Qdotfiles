#!/bin/bash
set -e

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

greeting(){
    setup_color
	printf "$GREEN"
	cat <<-'EOF'
         ____________________________________ 
        < You are using Qdotfiles! Have fun! >
         ------------------------------------ 
                \   ^__^
                 \  (oo)\_______
                    (__)\       )\/\
                        ||----w |
                        ||     ||
        
	EOF
	printf "$RESET"
}
insert_if_not_exists() {
    # not useful anymore...
    # if init.sh not in ~/.zsh, the add it
    # insert_if_not_exists 'source ~/.Qdotfiles/scripts/init.sh' ~/.zshrc
    content="$1"
    file=$2
    if ! grep -Fxq "$content" $file
    then
        echo "$content" >> $file
    fi
}


pre_set(){
    # get variables in mac or linux
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)
			sudo mkdir -p /usr/softwares/
			sudo chmod 777 -R /usr/softwares/
            ;;
        Darwin*)
            mkdir -p ~/applications/ 
            ;;
        *)
            echo "Not supported"
            exit 0
    esac
}

check_project(){
    # initialization for the dotfiles project
    PROJECT_PATH=~/.Qdotfiles
    if [ ! -d "$PROJECT_PATH" ]; then
        git clone https://github.com/QiangZibro/Qdotfiles  $PROJECT_PATH
        mkdir -p $PROJECT_PATH/downloads
    fi
    cd $PROJECT_PATH
}

setup_config(){
    # zshrc
    cp zsh/.zshrc ~

    # nvim
    mkdir -p ~/.config/nvim && cp neovim/init.vim ~/.config/nvim

    # tmux
    cp tmux/.tmux.conf ~

}

main(){
    greeting
    pre_set
    check_project
    setup_config
}

main
