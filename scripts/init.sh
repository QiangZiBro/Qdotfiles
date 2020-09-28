#!/bin/bash

source_if_exists(){
    file="$1"

    if [ -f "$file" ];then
        source "$file"
    fi
}

# ss
source ~/.Qdotfiles/ss/proxy.zsh

# zsh
source ~/.Qdotfiles/zsh/aliases.zsh
source ~/.Qdotfiles/zsh/theme.zsh

# zlua
source ~/.Qdotfiles/zlua/zlua.zsh

# github
source ~/.Qdotfiles/git/aliases.zsh

# ccat
source ~/.Qdotfiles/ccat/ccat.zsh

# conda
source ~/.Qdotfiles/conda/conda.zsh

# github
source_if_exists ~/.Qdotfiles/git/outh.sh

# docker
source ~/.Qdotfiles/docker/docker.zsh


# tmux
source ~/.Qdotfiles/tmux/tmux.zsh

# nvm
source ~/.Qdotfiles/nvm/nvm.zsh

if [ -f "~/.zsh_profile" ];then
	source ~/.zsh_profile
fi
