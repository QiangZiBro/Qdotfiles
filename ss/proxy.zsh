#!/bin/bash
MAC_PROXY_PORT=7890
LINUX_PROXY_PORT=8999

function _access_url() {
start=$SECONDS
result=$(curl -m 2 -I --silent www.$1.com | head -n 1 | awk -F' ' '{print $2}')
result=${result:-None}
dur=$((SECONDS - start))

if [ $result = "200" ]; then
  printf "[%.2f s] %-6s:200 OK✅\n" $dur $1
  return 0
else
  printf "[%.2f s] %-6s:${result}🚫\n" $dur $1
  return 1
fi
}
function _test_docker() {
  if ! command -v docker &>/dev/null; then
    echo "You do not have docker installed or not set in your environment"
    exit 0
  fi
}
 
_proxy_help() {
  cat <<EOF
Usage: proxy [on|off|up|down|status|restart|cmd|set|which|test]
Command:
 - on/off: set http/https proxy port
 - up/down/restart: set docker based service of command line proxy
 - set: select one from all ss configurations which are in ~/.Qdotfiles/ss/export.json
EOF
}
function _parse_on() {
  HTTP_PREFIX=
  HTTPS_PREFIX=
  if [ "$#" = 0 ]; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      PORT=$LINUX_PROXY_PORT
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      PORT=$MAC_PROXY_PORT
    fi
  fi
  # shellcheck disable=SC2071
  while [[ "$#" > 0 ]]; do case $1 in
    -p | --port)
      [ -z "$2" ] && echo "Please give port number" && return 1
      case "$2" in
      m | mac)
        PORT=$MAC_PROXY_PORT
        shift
        ;;
      l | linux)
        PORT=$LINUX_PROXY_PORT
        shift
        ;;
	  cl | clash)
		PORT=7890
		shift
		;;
      *)
        PORT=$2
        shift
        ;;
      esac
      shift
      ;;
    -h | --http)
      HTTP_PREFIX="http://"
      HTTPS_PREFIX="https://"
      shift
      ;;
    -s | --socks)
      PORT=1080
      PREFIX=
      HTTP_PREFIX="socks5://"
      HTTPS_PREFIX="socks5://"
      shift
      ;;
    --help)
      echo "proxy on [option]"
      echo "OPTIONS:"
      echo "  -h|--http"
      echo "  -s|--socks"
      echo "  -p|--port (linux|mac|1087)"
      ;;
    *)
      if (($1 >= 1000 && $1 <= 65535)); then
        PORT=$1
        shift
      else
        echo "Unknown parameter passed: $1"
        return 1
      fi
      ;;
    esac done
  export http_proxy="$HTTP_PREFIX""127.0.0.1:$PORT"
  export https_proxy="$HTTPS_PREFIX""127.0.0.1:$PORT"
  export HTTP_PROXY="$HTTP_PREFIX""127.0.0.1:$PORT"
  export HTTPS_PROXY="$HTTPS_PREFIX""127.0.0.1:$PORT"
}
proxy() {
  if test "$(uname)" = "Darwin"; then
    PROXY_PORT=$MAC_PROXY_PORT
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
    PROXY_PORT=$LINUX_PROXY_PORT
  fi

  if [ "$1" = "on" ]; then
    _parse_on "${@:2}"
  elif [ "$1" = "off" ]; then
    export http_proxy=""
    export https_proxy=""
    export HTTP_PROXY=""
    export HTTPS_PROXY=""
  elif [ "$1" = "status" ]; then
    _test_docker
    echo "--------------"
    echo "Proxy setting"
    echo "--------------"
    echo http_proxy="${http_proxy}"
    echo https_proxy="${https_proxy}"
    echo HTTP_PROXY="${HTTP_PROXY}"
    echo HTTPS_PROXY="${HTTPS_PROXY}"
    echo "--------------"
    echo "Network test"
    echo "--------------"
    proxy test
  elif [ "$1" = "up" ]; then
    cd ~/.Qdotfiles
    if [ "$2" = "-v" ]; then
      docker-compose up --remove-orphans
    elif [ "$2" = "-h" ]; then
      echo "proxy up [-vh]"
      echo "-v show debug info"
    else
      docker-compose up -d --remove-orphans
    fi
    cd - >/dev/null
  elif [ "$1" = "down" ]; then
    cd ~/.Qdotfiles
    docker-compose down --remove-orphans
    cd - >/dev/null
  elif [ "$1" = "in" ]; then
    cd ~/.Qdotfiles
    docker-compose exec Qlinux zsh
    cd - >/dev/null
  elif [ "$1" = "restart" ] || [ "$1" = "r" ]; then
    cd ~/.Qdotfiles
    docker-compose restart
    cd - >/dev/null
  elif [ "$1" = "onn" ]; then
    PROXY_PORT="${2:-${PROXY_PORT}}"
    export http_proxy="http://127.0.0.1:$PROXY_PORT"
    export https_proxy="https://127.0.0.1:$PROXY_PORT"
  elif [ "$1" = "cmd" ]; then
    # sometimes we may need to type msgs below, so copy it
    echo "Command to open http/s proxy"
    echo export http_proxy="127.0.0.1:$PROXY_PORT"
    echo export https_proxy="127.0.0.1:$PROXY_PORT"
    echo
    echo "Command to close http/s proxy"
    echo export http_proxy=
    echo export https_proxy=
  elif [ "$1" = "which" ]; then
    if [ -f ~/.Qdotfiles/ss/ss.json ]; then
      ip=$(cat ~/.Qdotfiles/ss/ss.json | grep server | grep -oE "([0-9]*\.){3}[0-9]*")
      port=$(cat ~/.Qdotfiles/ss/ss.json | grep server_port | grep -oE "[0-9]+")
      echo "proxy set \"$ip:$port\""
	

      if test "$(uname)" = "Darwin"; then
        echo "proxy set \"$ip:$port\"" | pbcopy
	  fi
	fi
  elif [ "$1" = "test" ]; then
    cg
  elif [ "$1" = "set" ]; then
	  python ~/.Qdotfiles/ss/set.py "${@:2}"
  else
    _proxy_help
  fi
}

change_ss() {
  cd ~/.Qdotfiles/ss
  PYTHON_VERSION=$(python -V | awk -F' ' '{print $2}' | awk -F'.' '{print $1}')
  if command -v python3 &>/dev/null; then
    python3 update_ss.py "$@"
  else
    [[ $(PYTHON_VERSION) = "3" ]] && python update_ss.py "$@" || exit 1
  fi
  cd - >/dev/null
}
