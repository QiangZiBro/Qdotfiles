set -ex
cd $(dirname $0)/..

if [ "$1" = "push" ];then
    git pull origin master
    bash ~/.Qdotfiles/scripts/backup.sh
    git add -A && git commit -m 'update from ci'
    git push origin master

elif [ "$1" = "pull" ];then
    git pull origin master
    if [ "$2" = "all" ];then
        ssh l1 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull" &# ssh执行远程脚本
        ssh l2 "/bin/bash /home/qiangzibro/.Qdotfiles/.ci/update.sh pull" &# ssh执行远程脚本
    fi
fi
