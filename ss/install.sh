#!/bin/bash

# Smartly use code below, this code can't find command for alias
if ! command -v sslocal &>/dev/null; then
  # installation process...
  if test "$(uname)" = "Darwin"; then
    # mac installation branch
    echo mac install

  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
    # linux installation branch
    echo linux install
    sudo apt install shadowsocks privoxy -y

  fi

fi
