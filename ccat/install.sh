#!/bin/bash

# Smartly use code below, this code can't find command for alias
# installation process...
if test "$(uname)" = "Darwin"; then
  # mac installation branch
  brew install pygments

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
  # linux installation branch
  pip install pygments
fi
