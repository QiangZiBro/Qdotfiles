function _access_url()
{
	1=${1:-google}
	result=$(curl -m 2 -I --silent www.$1.com | head -n 1 | awk -F' ' '{print $2}')
	if [ $result = "200" ];then
		echo "${1}:200 OK"😎
	else
		echo "${1}:${result}"😭
	fi

	
}

function cg(){
	_access_url baidu
    _access_url google
}
function _proxy_help(){
cat << EOF
Usage: proxy [on|off|up|down|restart|cmd|set|which|test]
Command:
 - on/off: set http/https proxy port
 - up/down/restart: set docker based service of command line proxy
 - set: select one from all ss configurations which are in ~/.Qdotfiles/ss/export.json
EOF
}
function proxy(){
	if test "$(uname)" = "Darwin";then
		PROXY_PORT=1087
	elif test "$(expr substr $(uname -s) 1 5)" = "Linux";then
		PROXY_PORT=8999
	fi

	if [ "$1" = "on" ]; then
		PROXY_PORT="${2:-${PROXY_PORT}}"
		export http_proxy="127.0.0.1:$PROXY_PORT"
		export https_proxy="127.0.0.1:$PROXY_PORT"
		# docker pull proxy needs this
		# https://docs.docker.com/config/daemon/systemd/#httphttps-proxy
		export HTTP_PROXY="127.0.0.1:$PROXY_PORT"
		export HTTPS_PROXY="127.0.0.1:$PROXY_PORT"
	elif [ "$1" = "off" ]; then
		export http_proxy=""
		export https_proxy=""
		export HTTP_PROXY=""
		export HTTPS_PROXY=""

	elif [ "$1" = "up" ]; then
		cd ~/.Qdotfiles
		docker-compose up -d --remove-orphans
		cd - > /dev/null
	elif [ "$1" = "down" ]; then
		cd ~/.Qdotfiles
		docker-compose down --remove-orphans
		cd - > /dev/null
	elif [ "$1" = "restart" ] || [ "$1" = "r" ]; then
		cd ~/.Qdotfiles
		docker-compose restart
	 	cd - > /dev/null
	elif [ "$1" = "onn" ]; then
		PROXY_PORT="${2:-${PROXY_PORT}}"
		export http_proxy="http://127.0.0.1:$PROXY_PORT"
		export https_proxy="https://127.0.0.1:$PROXY_PORT"
	elif [ "$1" = "cmd" ];then
		echo export http_proxy="127.0.0.1:$PROXY_PORT"
		echo export https_proxy="127.0.0.1:$PROXY_PORT"
	elif [ "$1" = "which" ];then
		cat ~/.Qdotfiles/ss/ss.json
	elif [ "$1" = "test" ];then
		cg
	elif [ "$1" = "set" ];then
		change_ss "${@:2}"
	else
		_proxy_help
	fi
}

function change_ss(){
	cd ~/.Qdotfiles/ss
	python update_ss.py "$@"
	cd - > /dev/null
}
