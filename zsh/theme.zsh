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
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  # If we can't get zplug, it'll be a very sobering shell experience. To at
  # least complete the sourcing of this file, we'll define an always-false
  # returning zplug function.
  if [[ $? != 0 ]]; then
    function zplug() {
      return 1
    }
  fi
fi
export ZPLUG_HOME=~/.zplug
if [[ -d "${ZPLUG_HOME}" ]]; then
  source "${ZPLUG_HOME}/init.zsh"
fi
zplug 'plugins/git', from:oh-my-zsh, if:'which git'
zplug 'romkatv/powerlevel10k', use:powerlevel10k.zsh-theme
# zplug "plugins/vi-mode", from:oh-my-zsh
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions', defer:2
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

if ! zplug check; then
  zplug install
fi

zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.Qdotfiles/zsh/.p10k.zsh ]] || source ~/.Qdotfiles/zsh/.p10k.zsh
#POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
#POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
#POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
#POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%F{white}"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{white} "
#
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs pyenv)
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir dir_writable_joined)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time vcs background_jobs_joined)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time vcs background_jobs_joined time_joined)
#POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
#POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
#POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
#POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"
#POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
#POWERLEVEL9K_DIR_HOME_FOREGROUND="green"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
#POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
#POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
#POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
#POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
#POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
#POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
#POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
#POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
#POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
#POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
#POWERLEVEL9K_TIME_BACKGROUND="clear"
#POWERLEVEL9K_TIME_FOREGROUND="cyan"
#POWERLEVEL9K_TIME_FORMAT="\UF43A %D{%I:%M  \UF133  %m.%d.%y}"
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='magenta'
#POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='clear'
#POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='green'
