alias de="docker exec"
alias dcu="docker-compose up"
alias dcd="docker-compose up -d"
alias dce="docker-compose exec"
alias dcb="docker-compose build"
alias ddown="docker-compose down"

#docker_rm_none(){
#    EXITED_CONTAINER=$(docker ps -a | grep "Exited" | awk '{print $1 }')
#    if [ ! -z "$EXITED_CONTAINER" ];
#    then
#        docker stop  $EXITED_CONTAINER
#        docker rm  $EXITED_CONTAINER 
#    fi
#
#    NONE_IMAGES=$(docker images | grep "none" | awk '{print $3}')
#    if [ ! -z "$NONE_IMAGES" ];
#    then
#        echo rm $NONE_IMAGES over
#        docker rmi  -f $NONE_IMAGES
#    fi
#}
