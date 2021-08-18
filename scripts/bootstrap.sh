#!/bin/bash
set -e
if [ `whoami` = "root" ];then
	SUDO=
else
	SUDO=sudo
fi


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
 ______________________________________
/     你好，欢迎使用Qdotfiles！        \
| Hello, Welcome to use Qdotfiles!      |
\ Hola,¡bienvenido a usar Qdotfiles!   /
 -------------------------------------- 
      \                    / \  //\
       \    |\___/|      /   \//  \\
            /0  0  \__  /    //  | \ \    
           /     /  \/_/    //   |  \  \  
           @_^_@'/   \/_   //    |   \   \ 
           //_^_/     \/_ //     |    \    \
        ( //) |        \///      |     \     \
      ( / /) _|_ /   )  //       |      \     _\
    ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
  (( / / )) ,-{        _      `-.|.-~-.           .~         `.
 (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
 (( /// ))      `.   {            }                   /      \  \
  (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
             ///.----..>        \             _ -~             `.  ^-`  ^-_
               ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
                                                                  /.-~
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

cp_file_if_exists(){
    if [ -f "$1" -a -e $2 ];
    then
        cp "$1" "$2"
    fi
}

pre_set(){
    # get variables in mac or linux
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)
			if [ ! -d /usr/local/softwares/ ];then
				echo INFO:Creating directory in /usr/local/softwares/, may need sudo priviledge
				$SUDO mkdir -p /usr/local/softwares/
				$SUDO chmod 777 -R /usr/local/softwares/
			fi
            ;;
        Darwin*)
            mkdir -p ~/applications/ 
            ;;
        *)
            echo "System not supported, support [mac|linux], abort!"
            exit 0
    esac
}

check_project(){
    # initialization for the dotfiles project
    QDOTFILES=~/.Qdotfiles
    if [ ! -d "$QDOTFILES" ]; then
        git clone https://github.com/QiangZibro/Qdotfiles  $QDOTFILES
        mkdir -p $QDOTFILES/downloads
	#else
	#	cd $QDOTFILES
	#	git pull 
    fi
    cd $QDOTFILES
}

setup_config(){
    # zshrc
    cp zsh/.zshrc ~
	cp_file_if_exists zsh/.zsh_profile ~

    # nvim
    mkdir -p ~/.config/nvim && cp neovim/init.vim ~/.config/nvim

    # tmux
    cp tmux/.tmux.conf ~

	# git
	cp git/.gitconfig ~
	cp git/.gitmessage ~
	cp_file_if_exists git/.git-credentials ~

	# ssh
	cp_file_if_exists ssh/config ~/.ssh

	# python
	cp conda/.condarc ~
	cp -r .pip ~

}

main(){
    greeting
    pre_set
    check_project
    setup_config
	exec zsh
}

main
