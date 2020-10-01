#TODO:写一个参数解析
[ -z $2 ] && file="export.json" || file=$2
if [ ! -z "$1" ];then
	python ./update_ss.py -i $1 -p "$2" -f $file  -r
fi
