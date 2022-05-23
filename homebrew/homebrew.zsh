[ -f /home/$USER/.linuxbrew/bin/brew ] && /home/$USER/.linuxbrew/bin/brew shellenv > /dev/null
if [ -d ~/.linuxbrew/bin ];then
	export PATH=${PATH}:~/.linuxbrew/bin
fi

