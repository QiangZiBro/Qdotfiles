update_ss(){
    set -ex
    cd $(dirname $0)/../ss
    if [ ! -z $1 ]
    then
        cat export.json| jq '.configs' | jq '[.[] | select(.server=="$1")][0]' > ss.json
	else
		exit 1
    fi
}

upload_ss_configure(){
    set +e
    scp -o ConnectTimeout=5 ss.json l1:~/.Qdotfiles/ss/
    scp -o ConnectTimeout=5 ss.json l2:~/.Qdotfiles/ss/
}

update_ss "$@"
upload_ss_configure
