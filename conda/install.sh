#!/bin/bash

# Smartly use code below, this code can't find command for alias
#if ! command -v  conda &> /dev/null
#then
    # installation process...
    if test "$(uname)" = "Darwin"
    then
        # download
        conda_mac=~/.Qdotfiles/downloads/miniconda3_mac.sh
        if [ ! -f $conda_mac ]
        then
            wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O $conda_mac
        fi

        # install
        bash $conda_mac -p /Users/mac/applications/miniconda3 -b
        # config for zsh
        ./condabin/conda init zsh

    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
        conda_linux=~/.Qdotfiles/downloads/miniconda3_linux.sh
         # linux installation branch
        if [ ! -f $conda_linux ]
        then
            wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $conda_linux
        fi


        # install, I want to install as multi-user 
	    echo install conda
        sudo bash $conda_linux -p /usr/local/softwares/miniconda3 -b -u
    fi
#fi

