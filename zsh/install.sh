#!/bin/bash
# Thanks to ChatGPT I nowadays write shell scripts easier...

source $(dirname $(realpath "$0"))/../scripts/util_vars.sh

# 安装 zsh 函数
install_zsh() {
    echo -e "${QD_BLUE}📦 安装 zsh...${QD_NC}"
    
    case $QD_OS_NAME in
        ubuntu|debian|kali|raspbian)
            ${SUDO} apt update
            ${SUDO} apt install -y zsh zsh-syntax-highlighting zsh-autosuggestions
            ;;
            
        centos|rhel|fedora|amzn|almalinux|rocky)
            if command -v dnf &> /dev/null; then
                ${SUDO} dnf install -y zsh util-linux-user
            else
                ${SUDO} yum install -y zsh
            fi
            ;;
            
        arch|manjaro)
            ${SUDO} pacman -Sy --noconfirm zsh
            ;;
            
        alpine)
            ${SUDO} apk add zsh
            ;;
            
        macos)
            if ! command -v brew &> /dev/null; then
                echo -e "${QD_RED}❌ Homebrew 未安装，请先安装 Homebrew${QD_NC}"
                echo -e "${QD_YELLOW}安装命令: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${QD_NC}"
                return 1
            fi
            brew install zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions
            ;;
            
        *)
            echo -e "${QD_RED}❌ 不支持的系统: $QD_OS_NAME${QD_NC}"
            echo -e "${QD_YELLOW}💡 请手动安装 zsh${QD_NC}"
            return 1
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        echo -e "${QD_GREEN}✅ zsh 安装成功${QD_NC}"
        return 0
    else
        echo -e "${QD_RED}❌ zsh 安装失败${QD_NC}"
        return 1
    fi
}

# 设置 zsh 为默认 shell
set_zsh_as_default() {
    echo -e "${QD_BLUE}⚙️  设置 zsh 为默认 shell...${QD_NC}"
    
    local zsh_path=$(which zsh 2>/dev/null)
    
    if [ -z "$zsh_path" ]; then
        echo -e "${QD_RED}❌ 未找到 zsh 可执行文件${QD_NC}"
        return 1
    fi
    
    # 检查当前 shell
    local current_shell=$(basename "$SHELL")
    if [ "$current_shell" = "zsh" ]; then
        return 0
    fi
    
    # 确保 zsh 在 /etc/shells 中
    # if ! grep -qxF "$zsh_path" /etc/shells 2>/dev/null; then
    #     echo -e "${QD_YELLOW}📝 将 zsh 添加到 /etc/shells...${QD_NC}"
    #     echo "$zsh_path" | ${SUDO} tee -a /etc/shells > /dev/null
    # fi
    
    # 更改默认 shell
    echo -e "${QD_YELLOW}🔄 更改默认 shell...${QD_NC}"
    if ${SUDO} chsh -s "$zsh_path" "$USER" 2>/dev/null; then
        echo -e "${QD_GREEN}✅ 成功设置 zsh 为默认 shell${QD_NC}"
        echo -e "${QD_YELLOW}📝 更改将在下次登录时生效${QD_NC}"
    else
        # 如果 ${SUDO} chsh 失败，尝试其他方法
        echo -e "${QD_YELLOW}⚠️  尝试其他方法更改 shell...${QD_NC}"
        if command -v usermod &> /dev/null; then
            ${SUDO} usermod -s "$zsh_path" "$USER"
            echo -e "${QD_GREEN}✅ 通过 usermod 设置成功${QD_NC}"
        else
            echo -e "${QD_RED}❌ 无法更改默认 shell${QD_NC}"
            echo -e "${QD_YELLOW}💡 请手动执行: chsh -s $(which zsh)${QD_NC}"
            return 1
        fi
    fi
}

# 安装 oh-my-zsh
install_oh_my_zsh() {
    echo -e "${QD_BLUE}🎨 安装 oh-my-zsh...${QD_NC}"
    
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${QD_GREEN}✅ oh-my-zsh 已安装${QD_NC}"
        return 0
    fi
    
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    if [ $? -eq 0 ] && [ -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${QD_GREEN}✅ oh-my-zsh 安装成功${QD_NC}"
        return 0
    else
        echo -e "${QD_RED}❌ oh-my-zsh 安装失败${QD_NC}"
        return 1
    fi
}

# 安装常用插件
install_zsh_plugins() {
    echo -e "${QD_BLUE}🔌 安装 zsh 插件...${QD_NC}"
    
	if ! test -d ~/.zplug; then
	   curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	fi
    echo -e "${QD_GREEN}✅ 常用插件安装完成${QD_NC}"
}

configure_zsh() {
	echo -e "${BLUE}🎛️  配置 zsh...${NC}"
	cp $(dirname $(realpath "$0"))/.zshrc ~
	source ~/.zshrc
    echo -e "${QD_GREEN}✅ 配置完成${QD_NC}"
}
# 主执行流程
main() {
    echo -e "${QD_BLUE}================================${QD_NC}"
    echo -e "${QD_GREEN}🚀 zsh 安装和配置脚本${QD_NC}"
    echo -e "${QD_BLUE}================================${QD_NC}"
    # 安装 zsh
    if command -v zsh &> /dev/null; then
        echo -e "${QD_GREEN}✅ zsh 已安装，版本: $(zsh --version | head -n1)${QD_NC}"
    else
        install_zsh
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
    set_zsh_as_default
	install_oh_my_zsh
	install_zsh_plugins
	configure_zsh


    # 完成提示
	echo
    echo -e "${QD_GREEN}🎉 zsh 安装和配置完成！${QD_NC}"
    echo -e "${QD_YELLOW}📋 下一步操作:${QD_NC}"
    echo -e "  1. 重新登录或执行: ${QD_BLUE}exec zsh${QD_NC}"
    echo -e "  2. 查看 zsh 配置: ${QD_BLUE}cat ~/.zshrc${QD_NC}"
    echo -e "  3. 自定义配置: ${QD_BLUE}编辑 ~/.zshrc${QD_NC}"
}

# 执行主函数
main "$@"
