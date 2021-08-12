################################################################################
## Make man page colorful
################################################################################
export LESS_TERMCAP_mb=$'\E[1m\E[32m'
export LESS_TERMCAP_mh=$'\E[2m'
export LESS_TERMCAP_mr=$'\E[7m'
export LESS_TERMCAP_md=$'\E[1m\E[36m'
export LESS_TERMCAP_ZW=""
export LESS_TERMCAP_us=$'\E[4m\E[1m\E[37m'
export LESS_TERMCAP_me=$'\E(B\E[m'
export LESS_TERMCAP_ue=$'\E[24m\E(B\E[m'
export LESS_TERMCAP_ZO=""
export LESS_TERMCAP_ZN=""
export LESS_TERMCAP_se=$'\E[27m\E(B\E[m'
export LESS_TERMCAP_ZV=""
export LESS_TERMCAP_so=$'\E[1m\E[33m\E[44m'


# install zplug, plugin manager for zsh, https://github.com/zplug/zplug
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# zplug configruation
if [[ -d ~/.zplug ]]; then
	proxy on
    export ZPLUG_HOME=~/.zplug
    if [[ -d "${ZPLUG_HOME}" ]]; then
      source "${ZPLUG_HOME}/init.zsh"
    fi
    zplug 'plugins/git', from:oh-my-zsh, if:'which git'
    zplug 'romkatv/powerlevel10k', as:theme, depth:1
    [[ ! -f ~/.Qdotfiles/zsh/.p10k.zsh ]] || source ~/.Qdotfiles/zsh/.p10k.zsh
	
    zplug 'zsh-users/zsh-autosuggestions'
    zplug 'zsh-users/zsh-completions', defer:2
    zplug 'zsh-users/zsh-history-substring-search'
    zplug 'zsh-users/zsh-syntax-highlighting', defer:2
    
    if ! zplug check; then
      zplug install
    fi
    
    zplug load
    
fi
