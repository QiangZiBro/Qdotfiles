
CLEAR='\033[0m'
RED='\033[0;31m'

function usage() {
  if [ -n "$1" ]; then
    echo "${RED}☺️ $1${CLEAR}\n";
  fi

cat << EOF
Usage 1: add + commit + push
   .ci/update.sh push -m "do something"

Usage 2: push to specified destination
   .ci/update.sh push -t "HEAD"
   .ci/update.sh push -t "master"
   .ci/update.sh push -t "dev:dev"

Usage 3: 
   .ci/update.sh pull [-a]

Usage 4: git add + commit + push + origin pull + bootstrap
	.ci/update.sh update

Usage 5: use multi process
	.ci/update.sh [command] -d

EOF

  exit 1
}

# parse params
while [[ "$#" > 0 ]]; do case $1 in
  push) ACTION="push";shift;;
  pull) ACTION="pull";shift;;
  update) UPDATE=1;shift;;
  -h|--help) HELP=1; shift;;
  -m|--message) MESSAGE="$2"; shift;shift;;
  -t|--destination) DESTINATION="$2";shift;shift;;
  -a|--pull_all) PULL_ALL=1;shift;;
  -d|--daemon) DAEMON="&";shift;;
  *) usage "Unknown parameter passed: $1"; shift; shift;;
esac; done

# verify paams
if [ -n "$HELP" ];then usage "Lazy man script"; fi
if [ -z "$MESSAGE" ]; then MESSAGE='update from ci';fi
if [ -z "$DESTINATION" ]; then DESTINATION='master';fi


pre_check(){
	# 如果有网络问题使用这个
	IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' |\
		grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -Ev '172.*.0.1'`
	echo "#--------------------------------------------"
	echo INFO:updating in $IP
	echo ACTION:$ACTION, UPDATE:$UPDATE,  MESSAGE:$MESSAGE, DESTINATION:$DESTINATION, PULL_ALL:$PULL_ALL
	echo http_proxy:$http_proxy
	echo "#--------------------------------------------"
	source  ~/.Qdotfiles/ss/proxy.zsh
	proxy start
	cd ~/.Qdotfiles
}

github_update(){
    if [ "$ACTION" = "push" ];then
        git pull origin $DESTINATION
        bash ~/.Qdotfiles/scripts/backup.sh
        git add -A && git commit -m "$MESSAGE"
        git push origin $DESTINATION $DAEMON
		git push gitlab $DESTINATION $DAEMON
		wait
    
    elif [ "$ACTION" = "pull" ];then
        git pull origin $DESTINATION
        if [ -n "$PULL_ALL" ];then
            ssh l1 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull \
				-t \"$DESTINATION\" \
				" $DAEMON

            ssh l2 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull \
				-t \"$DESTINATION\" \
				" $DAEMON
			wait
        fi
    fi
}

pre_check
if [ -n "$UPDATE" ];then 
	.ci/update.sh push
	.ci/update.sh pull -a
    #ssh l1 "/bin/bash /home/qiangzibro/.Qdotfiles/scripts/bootstrap.sh"
    #ssh l2 "/bin/bash /home/qiangzibro/.Qdotfiles/scripts/bootstrap.sh"
elif [ -z "$ACTION" ];
	then usage "Action (push|pull) is not set";
else
	github_update "$@"
fi
