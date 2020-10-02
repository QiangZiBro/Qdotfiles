IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' |\
	grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -Ev '172.*.0.1'`
echo updating in $IP

cd $(dirname $0)/..
main(){
    if [ "$1" = "push" ];then
        git pull origin master
        bash ~/.Qdotfiles/scripts/backup.sh
        if [ -n "$2" ];then
            git add -A && git commit -m "$2"
        else
            git add -A && git commit -m 'update from ci'
        fi
        git push origin master &
		git push gitlab master &
		wait
    
    elif [ "$1" = "pull" ];then
        git pull origin master
        if [ "$2" = "all" ];then
            ssh l1 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull" &# ssh执行远程脚本
            ssh l2 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull" &# ssh执行远程脚本
			wait
        fi
    fi
}

main "$@"
