install:
	rsync -au . ~/.Qdotfiles
	~/.Qdotfiles/scripts/bootstrap.sh
