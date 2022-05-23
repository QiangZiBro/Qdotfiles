docker_rm_none() {
  docker stop $(docker ps -a | grep "Exited" | awk '{print $1 }') #停止容器
  docker rm $(docker ps -a | grep "Exited" | awk '{print $1 }')   #删除容器
  docker rmi $(docker images | grep "none" | awk '{print $3}')    #删除镜像
}
docker_show() {
  socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
}
dq() {
  name=("${(@f)$(docker ps --format '{{.Names}}' | fzf -m)}")
  for c in $name
  do
	  if [[ ! -z $c ]];then
		  docker stop $c
		  docker rm $c
	  fi
  done
}
de() {
# steal from https://github.com/MartinRamm/fzf-docker/blob/master/docker-fzf
  case $1 in 
	  "")
		  name=$(docker ps --format '{{.Names}}' | fzf)
		  ;;
	  u|user)
		  name=$(docker ps --format '{{.Names}}' | grep $USER | fzf)
		  ;;
	  *)
		  name=$(docker ps --format '{{.Names}}' | grep $1 | fzf)
		  ;;
  esac
  [[ -z $name ]] || eval "docker exec -it -w $PWD $name bash"
}

dr() {
	# dr $APP $CMD [ARGS]
	CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:=0,1}
	if [ ! -z "$ENV" ];then
		EXTRA="-e $ENV"
	fi
	docker exec -it -w $PWD -e "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"  $EXTRA $USER-$1 ${@:2}
}
# run command inside of docker container 
# - same working path in/outside of container
# - docker container's name should be $USER-$APP, so here we export $APP before run this command
d(){
	if [ -z "$APP" ];then
		name=$(docker ps --format '{{.Names}}' |grep $USER |fzf)
		if [ -z $name ];then
			return 1
		else
			export APP=$(echo ${name} | sed "s/$USER-//")
		fi
	fi
	dr $APP $@
}
da2(){
	export CUDA_VISIBLE_DEVICES="0,1"
	da "$@"
}
da4(){
	export CUDA_VISIBLE_DEVICES="0,1,2,3"
	da "$@"
}
da8(){
	export CUDA_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"
	da "$@"
}
d2(){
	export CUDA_VISIBLE_DEVICES="0,1"
	d "$@"
}
d4(){
	export CUDA_VISIBLE_DEVICES="0,1,2,3"
	d "$@"
}
d8(){
	export CUDA_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"
	d "$@"
}
