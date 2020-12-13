#!/bin/bash
# 请在这里添加要创建的用户
USERS="qiangzibro daxiongpro haochen "
setup_groups(){
    echo "🌝 Create user groups..."

    for GROUPNAME in docker deepones
     
    do
        getent group $GROUPNAME 2>&1 >/dev/null && echo "INFO: $GROUPNAME already exists"|| groupadd $GROUPNAME
    done
}
create_user(){
    #----------------------------------------------------------------------------------
    # 创建一个用户，并进行组设置、shell设置
    #----------------------------------------------------------------------------------
    [ -z $1 ] && echo "No user name input and abort!" && exit 0
    USERNAME=$1
    
    if [ -d "/home/$USERNAME" ]
    then
        printf "INFO: User \"$USERNAME\" already exists\n"
    else
        # -G 该用户的其他组还应该属于的组，可以有多个
        # -m 创建用户的家目录
        # -s 该用户的登录shell
        # -p 该用户的密码
        useradd  -G docker,deepones,sudo -m -s /bin/zsh $USERNAME 
        echo "$USERNAME:$USERNAME" | chpasswd
    fi
}

create_users() {
    echo "🌝 Creating users..."
    for user in ${USERS}
    do
        create_user $user
    done
}
setup_groups
create_users 
