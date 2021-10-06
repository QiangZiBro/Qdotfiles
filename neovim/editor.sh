if ! command -V nvim 2>&1 > /dev/null ;then
	export EDITOR=vim
	alias vi=vim
	alias nvim=vim
else
	export EDITOR=nvim
	alias vi=nvim
	alias vim=nvim
fi
