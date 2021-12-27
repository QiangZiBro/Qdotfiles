#!/bin/bash
set -e
if [ $(whoami) = "root" ]; then
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

greeting() {
  setup_color
  printf "$GREEN"
  cat <<-'EOF'
 __________________________________
/          QiangZiBro              \
| Hello, Welcome to use Qdotfiles!  |
| Useful tools:                     |
|   qdot -h                         | 
|   proxy -h                        |
\   qtool -h                        /
 ----------------------------------
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

cp_file_if_exists() {
  if [ -f "$1" -a -e $2 ]; then
    cp "$1" "$2"
  fi
}

pre_set() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
  Linux*)
    if [ ! -d /usr/local/softwares/ ]; then
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
    ;;
  esac
  # TODO: check the user is using zsh or not, if not, use set user to use zsh
  # if not exists zsh, install zsh
}

check_project() {
  # initialization for the dotfiles project
  QDOTFILES=~/.Qdotfiles
  if [ ! -d "$QDOTFILES" ]; then
    git clone https://github.com/QiangZibro/Qdotfiles $QDOTFILES
    mkdir -p $QDOTFILES/downloads
  fi
  cd $QDOTFILES
}

setup_config() {
  # zshrc
  cp zsh/.zshrc ~
  cp_file_if_exists zsh/.zsh_profile ~

  # nvim
  mkdir -p ~/.config/nvim && cp neovim/init.vim ~/.config/nvim
  cp ~/.Qdotfiles/neovim/coc-settings.json ~/.config/nvim/coc-settings.json

  # tmux
  cp tmux/.tmux.conf ~

  # git
  cp git/.gitconfig ~
  cp git/.gitmessage ~
  cp_file_if_exists git/.git-credentials ~

  # alacritty
  mkdir -p ~/.config/alacritty && cp alacritty/alacritty.yml ~/.config/alacritty/

  # ssh
  cp_file_if_exists ssh/config ~/.ssh

  # python
  cp conda/.condarc ~
  # yabai
  if [[ "$OSTYPE" == "darwin"* ]]; then
	mkdir -p ~/.config/yabai
	cp yabai/yabairc ~/.config/yabai/
  fi
}

main() {
  greeting
  pre_set
  check_project
  setup_config
  exec zsh
}

main
