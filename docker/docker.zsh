docker_rm_none(){
    EXITED_CONTAINER=$(docker ps -a | grep "Exited" | awk '{print $1 }')
    if [ ! -z "$EXITED_CONTAINER" ];
    then
        docker stop  $EXITED_CONTAINER
        docker rm  $EXITED_CONTAINER 
    fi

    NONE_IMAGES=$(docker images | grep "none" | awk '{print $3}')
    if [ ! -z "$NONE_IMAGES" ];
    then
        docker rmi  $NONE_IMAGES
    fi
}
