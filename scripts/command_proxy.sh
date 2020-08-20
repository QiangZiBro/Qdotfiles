#!/bin/sh

#------------------------------------------------------------------------------
# Configure the service. This script runs in docker container
#------------------------------------------------------------------------------
set -ex
start=$1
/usr/sbin/privoxy --no-daemon /etc/privoxy/config &

cd $(dirname $0)/..
if [ "$start" = "daemon" ]; then
    sslocal -c ss/ss.json 2>&1 >/dev/null &
    sleep 2
else
    sslocal -c ss/ss.json
fi

cat << EOF
Usage:
PROXY_PORT=8118
export http_proxy=127.0.0.1:$PROXY_PORT
export https_proxy=127.0.0.1:$PROXY_PORT
curl google.com
git config --global https.proxy https://127.0.0.1:$PROXY_PORT
EOF
