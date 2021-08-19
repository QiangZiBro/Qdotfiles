#!/bin/bash
# set -x
cd $(dirname $0)/..
SS_PORT_IN_FILES="privoxy/config ss/ss.json scripts/setup_ss_privoxy_port.sh"
PRIVOXY_PORT_IN_FILES="docker-compose.yml scripts/cproxy ss/proxy.zsh privoxy/config scripts/setup_ss_privoxy_port.sh .env"

read -p "ss port [default 1080]:" SS_PORT
SS_PORT=${SS_PORT:-1080}
read -p "privoxy port [default 8999]:" PRIVOXY_PORT
PRIVOXY_PORT=${PRIVOXY_PORT:-8999}

echo SS_PORT:"$SS_PORT", PRIVOXY_PORT:"$PRIVOXY_PORT"

while true; do
  read -p "Are you sure? Y/n:" yn
  case $yn in
  [Yy]*)
    if test "$(uname)" = "Darwin"; then

      sed -i '' "s|1080|$SS_PORT|g" $SS_PORT_IN_FILES
      sed -i '' "s|8999|$PRIVOXY_PORT|g" $PRIVOXY_PORT_IN_FILES
    else
      sed -i "s|1080|$SS_PORT|g" $SS_PORT_IN_FILES
      sed -i "s|8999|$PRIVOXY_PORT|g" $PRIVOXY_PORT_IN_FILES
    fi
    break
    ;;
  [Nn]*) exit ;;
  *) echo "Please answer yes or no." ;;
  esac
done
