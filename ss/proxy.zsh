function cg(){
	curl -I www.google.com
}
function proxy(){
    if test "$(uname)" = "Darwin";then
        # mac branch
        PROXY_PORT=1087
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux";then
        # linux branch
        PROXY_PORT=8999
    fi

    if [ "$1" = "start" ]; then
        export http_proxy="http://127.0.0.1:$PROXY_PORT"
        export https_proxy="https://127.0.0.1:$PROXY_PORT"
        git config --global https.proxy https://127.0.0.1:$PROXY_PORT
    elif [ "$1" = "stop" ]; then
        export http_proxy=""
        export https_proxy=""
        git config --global https.proxy ''
	elif [ "$1" = "cmd" ];then
        echo export http_proxy="http://127.0.0.1:$PROXY_PORT"
        echo export https_proxy="https://127.0.0.1:$PROXY_PORT"
        echo git config --global https.proxy https://127.0.0.1:$PROXY_PORT
    else
        echo "Wrong parameter!Usage: proxy [start|stop]"
    fi
}

function change_ss(){
	cd ~/.Qdotfiles/ss
	python update_ss.py "$@"
}
