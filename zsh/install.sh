#!/bin/bash
set -ex

if test "$(uname)" = "Darwin"; then
  # mac installation branch
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
  echo installing zsh
  # linux installation branch
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -qO - | zsh
  cp ~/.Qdotfiles/zsh/.zshrc ~/.zshrc
  sudo chsh $USER -s $(which zsh)
fi

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh && source ~/.Qdotfiles/zsh/theme.zsh
