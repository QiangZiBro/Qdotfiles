#!/bin/bash
# set -x
cd $(dirname $0)/..
SS_PORT=
SS_PORT_IN_FILES="privoxy/config ss/ss.json"
PRIVOXY_PORT=
PRIVOXY_PORT_IN_FILES="docker-compose.yml scripts/cproxy ss/proxy.zsh privoxy/config"

read -p "ss port[default 1080]:" SS_PORT
read -p "privoxy port [default 8118]:" PRIVOXY_PORT

echo SS_PORT:"$SS_PORT", PRIVOXY_PORT:"$PRIVOXY_PORT"
echo make change in $SS_PORT_IN_FILES $PRIVOXY_PORT_IN_FILES


while true; do
    read -p "Are you sure? Y/n:" yn
    case $yn in
        [Yy]* ) 
            sed "s|1080|$SS_PORT|g" $SS_PORT_IN_FILES
            sed "s|8118|$PRIVOXY_PORT|g" $PRIVOXY_PORT_IN_FILES
            break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

