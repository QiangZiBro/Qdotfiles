#!/usr/bin/env bash

QD_HOME=$(dirname $(dirname $(realpath "$0")))

# 颜色定义
QD_RED='\033[0;31m'
QD_GREEN='\033[0;32m'
QD_YELLOW='\033[1;33m'
QD_BLUE='\033[0;34m'
QD_NC='\033[0m' # No Color

# 获取系统信息和架构版本
QD_OS_NAME="unknown"
QD_OS_VERSION="unknown"
QD_ARCH="unknown"
QD_PLATFORM="unknown"

get_system_info() {
    # 初始化变量
    # 获取架构信息
    QD_ARCH=$(uname -m)
    case $QD_ARCH in
        x86_64)      QD_ARCH="x86_64" ;;
        aarch64)     QD_ARCH="arm64" ;;
        armv7l)      QD_ARCH="armv7" ;;
        armv6l)      QD_ARCH="armv6" ;;
        i386|i686)   QD_ARCH="i386" ;;
        *)           QD_ARCH="$QD_ARCH" ;;
    esac

    # 获取平台信息
    QD_PLATFORM=$(uname -s)
    case $QD_PLATFORM in
        Darwin)  QD_PLATFORM="macos" ;;
        Linux)   QD_PLATFORM="linux" ;;
        *)       QD_PLATFORM="$QD_PLATFORM" ;;
    esac

    # 获取具体的操作系统信息
    if [[ "$QD_PLATFORM" == "linux" ]]; then
        # Linux 系统
        if [[ -f /etc/os-release ]]; then
            source /etc/os-release
            QD_OS_NAME=$ID
            QD_OS_VERSION=$VERSION_ID
        elif [[ -f /etc/centos-release ]]; then
            QD_OS_NAME="centos"
            QD_OS_VERSION=$(grep -oE '[0-9]+\.[0-9]+' /etc/centos-release | head -1)
        elif [[ -f /etc/redhat-release ]]; then
            QD_OS_NAME="rhel"
            QD_OS_VERSION=$(grep -oE '[0-9]+\.[0-9]+' /etc/redhat-release | head -1)
        elif [[ -f /etc/debian_version ]]; then
            QD_OS_NAME="debian"
            QD_OS_VERSION=$(cat /etc/debian_version)
        fi
    elif [[ "$QD_PLATFORM" == "macos" ]]; then
        # macOS 系统
        QD_OS_NAME="macos"
        QD_OS_VERSION=$(sw_vers -productVersion)
    fi
}

# 使用函数并导出变量
get_system_info

# # # 显示获取到的信息
# echo "系统平台: $QD_PLATFORM"
# echo "操作系统: $QD_OS_NAME"
# echo "系统版本: $QD_OS_VERSION"
# echo "处理器架构: $QD_ARCH"

# # 现在可以在脚本中使用这些变量
# echo "组合信息: ${QD_OS_NAME}-${QD_OS_VERSION}-${QD_ARCH}"
# echo "QD_HOME: ${QD_HOME}"
