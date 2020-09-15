CLEAR='\033[0m'
RED='\033[0;31m'

function usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}☺️ $1${CLEAR}\n";
  fi
  echo "  -f, --from		Your total config json"
  echo "  -i, --ip			Your shadowsocks ip address"
  echo "  -r, --remote		Push results to remote machine"
  echo "  -h, --help"
  echo ""
  echo "Example:bash $0 -f ss/export.json -i 10.10.10.10"
  exit 1
}

# parse params
while [[ "$#" > 0 ]]; do case $1 in
  -f|--from) from="$2"; shift;shift;;
  -i|--ip) ip="$2"; shift;shift;;
  -r|--remote) REMOTE=1;shift;;
  -h|--help) HELP=1;shift;;
  *) usage "Unknown parameter passed: $1"; shift; shift;;
esac; done

if [ ! -z $HELP ]
then
	usage ""

fi


update_ss(){
    set -e
    cmd=" cat $2 | jq '.configs' | jq '[.[] | select(.server==\"$1\")][0]' > ss/ss.json" 
	echo $cmd
}

upload_ss_configure(){
    set +e
	cd $(dirname $0)/../ss
    scp -o ConnectTimeout=5 ss.json l1:~/.Qdotfiles/ss/
    scp -o ConnectTimeout=5 ss.json l2:~/.Qdotfiles/ss/
}

if [ ! -z $ip && ! -z $from ]; then update_ss "$ip" "$from" fi

if [ ! -z $REMOTE ];then
	echo ehllo w
	upload_ss_configure
fi
