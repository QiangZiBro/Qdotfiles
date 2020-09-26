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

elif [ "$1" = "-h" ];
then
cat << EOF
设置cuda的脚本，具有安装必备软件和禁止nouveau的功能。
第一步： 
sudo bash ./cuda_install_preset.sh -r
第二步：
sudo bash ./cuda_install_preset.sh
第三步：
安装你的驱动，比如
./cuda_*linux.run 

这个脚本使用方法：
	bash ./cuda_install_preset.sh [-rh]
		-r 禁止nouveau并重启
		-h 打印这个帮助文档并退出
		默认下载必备软件
EOF

exit 0
fi

if [ ! "$(expr substr $(uname -s) 1 5)" = "Linux" ]
then
	echo Your system is not linux, abort!
	exit 1
fi
sudo apt-get install -y g++ freeglut3-dev build-essential \
	libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
