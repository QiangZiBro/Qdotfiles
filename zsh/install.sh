#!/bin/bash
set -ex

# TODO:
# 1. check zsh is installed or not
# 2. if not, install it
# 3. install oh-my-zsh 
# 4. install theme file

if test "$(uname)" = "Darwin"; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -qO - | zsh
  cp ~/.Qdotfiles/zsh/.zshrc ~/.zshrc
  sudo chsh $USER -s $(which zsh)
fi

if ! test -d; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  source ~/.Qdotfiles/zsh/theme.zsh
fi
