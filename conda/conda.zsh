
if test "$(uname)" = "Darwin"
then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/mac/applications/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/mac/applications/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/mac/applications/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/mac/applications/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then


fi