disable_nouveau(){
cat << EOF >>/etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF
	
	update-initramfs -u
	reboot
}

if [ "$1" = "-r" ];then
	disable_nouveau
fi

sudo apt-get install -y g++ freeglut3-dev build-essential \
	libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
