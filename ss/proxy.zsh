if test "$(uname)" = "Darwin";then
    # mac branch
    PROXY_PORT=1087
    
elif test "$(expr substr $(uname -s) 1 5)" = "Linux";then
    # linux branch
    PROXY_PORT=8118
fi

function proxy(){
    if [ "$1" = "start" ]; then
        export http_proxy="127.0.0.1:$PROXY_PORT"
        export https_proxy="127.0.0.1:$PROXY_PORT"
        git config --global https.proxy https://127.0.0.1:$PROXY_PORT
    else
        if [ "$1" = "stop" ]; then
            export http_proxy=""
            export https_proxy=""
        else
            echo "Wrong parameter!Usage: proxy [start|stop]"
        fi
    fi
}
