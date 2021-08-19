sudo npm install -g diff-so-fancy

distribution=$(
  . /etc/os-release
  echo $ID$VERSION_ID
) &&
  curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - &&
  curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo cat <<EOF >/etc/docker/daemon.json
{
    "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
EOF
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
