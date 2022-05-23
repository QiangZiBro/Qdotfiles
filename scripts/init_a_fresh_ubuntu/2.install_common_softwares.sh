#!/bin/bash

softwares=(
git vim zsh silversearcher-ag ripgrep fd-find ranger net-tools
curl tree make htop nodejs npm snapd docker docker.io docker-compose
rename highlight python3.7 python3-pip
)
if test "$(uname)" = "Darwin"; then
  echo not supported now on mac now!

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
  for software in ${softwares[@]}
  do
	  sudo apt install -y $software
  done
  python3 -m pip install ranger-fm
fi
