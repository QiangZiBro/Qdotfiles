sudo npm install -g diff-so-fancy

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \\n   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \\n   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
curl -s -L https://nvidia.github.io/nvidia-container-runtime/experimental/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2

