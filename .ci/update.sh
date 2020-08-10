set -ex
cd $(dirname $0)/..
git pull origin master
bash ~/.Qdotfiles/scripts/backup.sh


git add -A && git commit -m 'update from ci'
git push origin HEAD
