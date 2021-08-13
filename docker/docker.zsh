alias d="docker"
alias d-c="docker-compose"
alias de="docker exec"
alias dr="docker-compose restart"
alias dcu="docker-compose up"
alias dcd="docker-compose up -d"
alias dce="docker-compose exec"
alias dcb="docker-compose build"
alias ddown="docker-compose down"

docker_rm_none(){
	docker stop $(docker ps -a | grep "Exited" | awk '{print $1 }') #停止容器
	docker rm $(docker ps -a | grep "Exited" | awk '{print $1 }') #删除容器
	docker rmi $(docker images | grep "none" | awk '{print $3}') #删除镜像
}
docker_show(){
	socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
}
