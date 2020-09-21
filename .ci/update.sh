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
        git push origin master
    
    elif [ "$1" = "pull" ];then
        git pull origin master
        if [ "$2" = "all" ];then
            ssh l1 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull" &# ssh执行远程脚本
            ssh l2 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull" &# ssh执行远程脚本
            ssh L2 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull" &# ssh执行远程脚本
        fi
    fi
}

main "$@"
