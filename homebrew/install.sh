#!/bin/bash
if command -v brew >/dev/null;then
	exit 0
fi
if [ $(uname) = "Linux" ];then
	mkdir -p ~/.linuxbrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.linuxbrew
	~/.linuxbrew/bin/brew 2>&1 >/dev/null
elif [ $(uname) = "Darwin" ];then
	 command -v brew >/dev/null && echo homebrew has been installed || /bin/bash -c \
	  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
	echo Only supported on MacOS and Linux
fi
