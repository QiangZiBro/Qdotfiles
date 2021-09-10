export EDITOR=nvim

for d in ~/.Qdotfiles/bin; do PATH="$PATH:$d"; done

if [ -d $HOME/.oh-my-zsh ];then
	export ZSH=$HOME/.oh-my-zsh
	plugins=(git)
	ZSH_THEME="robbyrussell"
	source $ZSH/oh-my-zsh.sh
fi

if [ -f ~/.Qdotfiles/scripts/init.sh ];then
	source ~/.Qdotfiles/scripts/init.sh
	proxy on
fi

