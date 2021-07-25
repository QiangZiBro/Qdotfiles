function _access_url()
{
	1=${1:-google}
	timeout 2 curl -I --silent www.$1.com | head -n 1 | awk -F' ' '{print $2}'
}

function cg(){
	BAIDU_RESULT=`_access_url baidu`
	echo "Baidu: $BAIDU_RESULT"

	GOOGLE_RESULT=`_access_url google`
	echo "Google: $GOOGLE_RESULT"
}
function proxy(){
	if test "$(uname)" = "Darwin";then
		PROXY_PORT=1087
	elif test "$(expr substr $(uname -s) 1 5)" = "Linux";then
		PROXY_PORT=8999
	fi

	if [ "$1" = "start" ]; then
		PROXY_PORT="${2:-${PROXY_PORT}}"
		export http_proxy="127.0.0.1:$PROXY_PORT"
		export https_proxy="127.0.0.1:$PROXY_PORT"
	if [ "$1" = "hstart" ]; then
		PROXY_PORT="${2:-${PROXY_PORT}}"
		export http_proxy="http://127.0.0.1:$PROXY_PORT"
		export https_proxy="https://127.0.0.1:$PROXY_PORT"
		# I found that setting http/https proxy directly works for git
		#git config --global https.proxy https://127.0.0.1:$PROXY_PORT
	elif [ "$1" = "stop" ]; then
		export http_proxy=""
		export https_proxy=""
		git config --global https.proxy ''
	elif [ "$1" = "cmd" ];then
		echo export http_proxy="http://127.0.0.1:$PROXY_PORT"
		echo export https_proxy="https://127.0.0.1:$PROXY_PORT"
		#echo git config --global https.proxy https://127.0.0.1:$PROXY_PORT
	elif [ "$1" = "which" ];then
		cat ~/.Qdotfiles/ss/ss.json
	elif [ "$1" = "test" ];then
		cg
	elif [ "$1" = "set" ];then
		change_ss "${@:2}"
	else
		echo "Wrong parameter!Usage: proxy [start|stop|cmd|which|test]"
	fi
}

function change_ss(){
	cd ~/.Qdotfiles/ss
	python update_ss.py "$@"
}
