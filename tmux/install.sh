#!/bin/bash
if test ! $(which tmux); then
  if test "$(uname)" = "Darwin"; then
    brew install tmux
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
    sudo apt install tmux
  fi
fi

# tmux plug manager
if [ ! -d ~/.tmux/plugins/ ]; then
  mkdir -p ~/.tmux/plugins/
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
  cd ~/.tmux/plugins/
  git clone https://github.com/tmux-plugins/tpm
fi
tmux source ~/.tmux.conf

exit 0
