CLEAR='\033[0m'
RED='\033[0;31m'

function usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}☺️ $1${CLEAR}\n";
  fi
  echo "Usage: $0 [-n number-of-people] [-s section-id] [-c cache-file]"
  echo "  -f, --from		Your total config json"
  echo "  -i, --ip			Your shadowsocks ip address"
  echo "  -r, --remote		Push results to remote machine"
  echo ""
  echo "Example:bash $0 -f ss/export.json -i 10.10.10.10"
  exit 1
}

# parse params
while [[ "$#" > 0 ]]; do case $1 in
  -f|--from) from="$2"; shift;shift;;
  -i|--ip) ip="$2"; shift;shift;;
  -r|--remote) REMOTE=1;shift;;
  *) usage "Unknown parameter passed: $1"; shift; shift;;
esac; done

# verify params
if [ -z "$ip" ]; then usage "Ip is not set"; fi;
if [ -z "$from" ]; then usage "Configurations export file is not set"; fi;

update_ss(){
    set -ex
    cd $(dirname $0)/../ss
    if [ ! -z $1 ]
    then
        cat export.json| jq '.configs' | jq '[.[] | select(.server=="$1")][0]' > ss.json
    fi
}

upload_ss_configure(){
    set +e
    scp -o ConnectTimeout=5 ss.json l1:~/.Qdotfiles/ss/
    scp -o ConnectTimeout=5 ss.json l2:~/.Qdotfiles/ss/
}

update_ss "$ip" "$from"
if [ ! -z $REMOTE ];then
	upload_ss_configure
fi
