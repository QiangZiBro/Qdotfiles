#!/bin/bash

# 交互式模式的初始化脚本
# 防止被加载两次
if [ -z "$_INIT_SH_LOADED" ]; then
  _INIT_SH_LOADED=1
else
  return
fi

# 如果是非交互式则退出，比如 bash test.sh 这种调用 bash 运行脚本时就不是交互式
# 只有直接敲 bash 进入的等待用户输入命令的那种模式才成为交互式，才往下初始化
case "$-" in
*i*) ;;
*) return ;;
esac

source_if_exists() {
  file="$1"

  if [ -f "$file" ]; then
    source "$file"
  fi
}
export PATH=$PATH:~/.Qdotfiles/git/custom
export PATH=$PATH:~/.Qdotfiles/bin
if test -d /snap/bin;then
	export PATH=$PATH:/snap/bin
fi
if test -d ~/.local/bin;then
	export PATH=$PATH:~/.local/bin
fi
if test -d ~/.qtools/bin;then
	export PATH=$PATH:~/.qtools/bin
fi
QDOTFILES="~/.Qdotfiles"

# ss
source ~/.Qdotfiles/ss/proxy.zsh

# zsh
if [ -d $HOME/.oh-my-zsh ];then
        export ZSH=$HOME/.oh-my-zsh
        plugins=(git)
        ZSH_THEME="robbyrussell"
        source $ZSH/oh-my-zsh.sh
fi
source ~/.Qdotfiles/zsh/theme.zsh

source_if_exists ~/.zsh_profile

# github
source ~/.Qdotfiles/git/aliases.zsh

# conda
source ~/.Qdotfiles/conda/conda.zsh

# docker
source ~/.Qdotfiles/docker/docker.zsh

# choose editor
if ! command -V nvim 2>&1 > /dev/null ;then
	export EDITOR=vim
	alias vi=vim
	alias nvim=vim
else
	export EDITOR=nvim
	alias vi=nvim
	alias vim=nvim
fi

# tmux
source ~/.Qdotfiles/tmux/tmux.zsh

# 命令补全
source ~/.Qdotfiles/scripts/completion.sh

# fzf命令补全
# 初始化 $(brew --prefix)/opt/fzf/install
source_if_exists ~/.fzf.zsh

# Homebrew
[ -f /home/$USER/.linuxbrew/bin/brew ] && /home/$USER/.linuxbrew/bin/brew shellenv > /dev/null
if [ -d ~/.linuxbrew/bin ];then
	export PATH=${PATH}:~/.linuxbrew/bin
fi

if [ -d ~/.vim/bundles/asynctasks.vim/bin ];then
	export PATH=${PATH}:~/.vim/bundles/asynctasks.vim/bin
fi

# 整理 PATH，删除重复路径
if [ -n "$PATH" ]; then
  old_PATH=$PATH:
  PATH=
  while [ -n "$old_PATH" ]; do
    x=${old_PATH%%:*}
    case $PATH: in
    *:"$x":*) ;;
    *) PATH=$PATH:$x ;;
    esac
    old_PATH=${old_PATH#*:}
  done
  PATH=${PATH#:}
  unset old_PATH x
fi
export PATH
