#!/bin/bash
# 为实验室写的用户创建脚本，请创建用户后改密码
#
# 请在这里添加要创建的用户
_arg_user="daxiongpro chenhao"
_arg_admin="qiangzibro chenkangxin"

die() {
  local _ret="${2:-1}"
  test "${_PRINT_HELP:-no}" = yes && print_help >&2
  echo "$1" >&2
  exit "${_ret}"
}

begins_with_short_option() {
  local first_option all_short_options='uah'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

print_help() {
  printf '%s\n' "User creation script"
  printf 'Usage: %s [-u|--user <arg>] [-a|--admin <arg>] [-h|--help]\n' "$0"
  printf '\t%s\n' "-u, --user: normal users which are put into docker, deepones group (no default)"
  printf '\t%s\n' "-a, --admin: administrator users which have sudo (no default)"
  printf '\t%s\n' "-h, --help: Prints help"
}

parse_commandline() {
  while test $# -gt 0; do
    _key="$1"
    case "$_key" in
    -u | --user)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_user="$2"
      shift
      ;;
    --user=*)
      _arg_user="${_key##--user=}"
      ;;
    -u*)
      _arg_user="${_key##-u}"
      ;;
    -a | --admin)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_admin="$2"
      shift
      ;;
    --admin=*)
      _arg_admin="${_key##--admin=}"
      ;;
    -a*)
      _arg_admin="${_key##-a}"
      ;;
    -h | --help)
      print_help
      exit 0
      ;;
    -h*)
      print_help
      exit 0
      ;;
    *)
      _PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
      ;;
    esac
    shift
  done
}

parse_commandline "$@"
##################################################################################
setup_groups() {
  echo "🌝 Create user groups..."

  for GROUPNAME in docker deepones; do
    getent group $GROUPNAME 2>&1 >/dev/null && echo "INFO: $GROUPNAME already exists" || groupadd $GROUPNAME
  done
}
create_user() {
  #----------------------------------------------------------------------------------
  # 创建一个用户，并进行组设置、shell设置
  #----------------------------------------------------------------------------------
  [ -z $1 ] && echo "No user name input and abort!" && exit 0
  USERNAME=$1

  if [ -d "/home/$USERNAME" ]; then
    printf "INFO: User \"$USERNAME\" already exists\n"
  else
    # -G 该用户的其他组还应该属于的组，可以有多个
    # -m 创建用户的家目录
    # -s 该用户的登录shell
    # -p 该用户的密码
    useradd -G "$2" -m -s /bin/zsh $USERNAME
    echo "$USERNAME:$USERNAME" | chpasswd
  fi
}

create_users() {
  echo "🌝 Creating users..."
  for user in ${_arg_user}; do
    create_user "$user" "docker,deepones"
  done
  for user in ${_arg_admin}; do
    create_user "$user" "docker,deepones,sudo"
  done
}

while true; do
  echo "Normal user:${_arg_user}"
  echo "Admin user:${_arg_admin}"
  read -p "Proceed?[Y/N]" yn
  case $yn in
  [Yy]*)
    setup_groups
    create_users
    break
    ;;
  [Nn]*) exit ;;
  *) echo "Please answer yes or no." ;;
  esac
done
