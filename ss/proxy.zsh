if test "$(uname)" = "Darwin"
    # mac branch
    #
    function proxy(){
        # If you a shadowsocksX-NG in your computer, you can
        # directly set http/https proxy in your terminal,
        # because it contains a privoxy server, else you have
        # to download a prixovy and config it!
        #
        # Note: I assume http/https port to be 1087, if not,
        #       modify them!
        if [ "$1" = "start" ]; then
            export http_proxy="127.0.0.1:1087"
            export https_proxy="127.0.0.1:1087"
            echo http_proxy=$http_proxy
            echo https_proxy=$https_proxy
            git config --global https.proxy https://127.0.0.1:1087
        else
            if [ "$1" = "stop" ]; then
                export http_proxy=""
                export https_proxy=""
                echo http_proxy=$http_proxy
                echo https_proxy=$https_proxy
            else
                echo "Wrong parameter!Usage: proxy [start|stop]"
            fi
        fi
    }

then
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
    # linux branch

fi
