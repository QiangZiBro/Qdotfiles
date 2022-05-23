#!/bin/bash

DEST=~/Downloads/miniconda3.sh
MACURL=https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
LINUXURL=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
if test "$(uname)" = "Darwin"; then
  if [ ! -f $DEST ]; then
    wget $MACURL -O $DEST
  fi
  bash $DEST -p ~/applications/miniconda3 -b
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
  if [ ! -f $DEST ]; then
    wget $LINUXURL -O $DEST
  fi
  sudo bash $DEST -p /usr/local/softwares/miniconda3 -b -u
fi
conda init "$(basename "${SHELL}")"
