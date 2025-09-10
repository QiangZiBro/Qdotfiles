#!/bin/bash
set -e

source $(dirname $(realpath "$0"))/util_vars.sh

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

pre_check() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
  Linux*)
  #  if [ ! -d /usr/local/softwares/ ]; then
  #    echo INFO:Creating directory in /usr/local/softwares/, may need sudo priviledge
  #    $SUDO mkdir -p /usr/local/softwares/
  #    $SUDO chmod 777 -R /usr/local/softwares/
  #  fi
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

setup_config_files() {
  # zshrc
  bash ${QD_HOME}/zsh/install.sh
  cp zsh/.zshrc ~
  cp_file_if_exists zsh/.zsh_profile ~

  # homebrew
  bash ${QD_HOME}/homebrew/install.sh

  # nvim
  mkdir -p ~/.config/nvim && cp neovim/init.vim ~/.config/nvim
  cp ~/.Qdotfiles/neovim/coc-settings.json ~/.config/nvim/coc-settings.json
  mkdir -p ~/.vim
  cp ~/.Qdotfiles/neovim/tasks.ini ~/.vim/

  # tmux
  cp tmux/.tmux.conf ~

  # ranger
  mkdir -p ~/.config
  rm -rf ~/.config/ranger
  cp -r ranger ~/.config

  # git
  cp git/.gitconfig ~
  cp git/.gitmessage ~
  cp_file_if_exists git/.git-credentials ~

  # ssh
  cp_file_if_exists ssh/config ~/.ssh

  # npm
  cp node/.npmrc ~

  # python
  cp conda/.condarc ~

  # lazygit
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	  if [ -d "$linux_lazygit" ];then
		  cp lazygit/config.yml ~/.config/lazygit
	  fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
	  if [ -d "$macos_lazygit" ];then
		  cp lazygit/config.yml "~/Library/Application Support/lazygit"
	  fi
  fi
}

main() {
  greeting
  check_project
  pre_check
  setup_config_files 

  cd $OLDPWD
  exec zsh
}

main
