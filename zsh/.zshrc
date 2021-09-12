export EDITOR=nvim
for d in ~/.Qdotfiles/bin; do PATH="$PATH:$d"; done
if [ -f ~/.Qdotfiles/scripts/init.sh ];then
	source ~/.Qdotfiles/scripts/init.sh
	proxy on
fi

