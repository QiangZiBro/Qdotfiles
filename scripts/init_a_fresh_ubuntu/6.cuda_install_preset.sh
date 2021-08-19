#---------------------------------------------------------------------------------
#  安装cuda驱动之前必须要进行的配置
#
#	  第一步：只装软件去掉-r参数
#		sudo bash ./cuda_install_preset.sh -r
#	  第二步：
#	  在https://developer.nvidia.com/cuda-downloads找到你的驱动runfile，下载，然后运行
#		./cuda_*linux.run
#---------------------------------------------------------------------------------
disable_nouveau() {
  cat <<EOF >>/etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF

  update-initramfs -u
  reboot
}

install_basic_softwares() {
  sudo apt-get install -y g++ freeglut3-dev build-essential \
    libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
}

if [ ! "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  echo Your system is not linux, abort!
  exit 1
fi

if [ "$1" = "-r" ]; then
  install_basic_softwares
  disable_nouveau

elif [ "$1" = "-h" ]; then
  cat <<EOF
设置cuda的脚本，具有安装必备软件和禁止nouveau的功能。

这个脚本使用方法：
	bash ./cuda_install_preset.sh [-rh]
		-r 禁止nouveau并重启
		-h 打印这个帮助文档并退出
		默认下载必备软件
EOF
  exit 0

else
  install_basic_softwares
fi
