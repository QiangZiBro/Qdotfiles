common_settings () {
    alias ei="nvim ~/.Qdotfiles/scripts/init.sh"
    alias grealpath=realpath
    alias fm="ranger"
    alias sb="source ~/.zshrc"
    alias eb="nvim ~/.zshrc"
    alias cb="cd ~/.Qdotfiles/zsh/"
}
mac_settings () {
    alias nvim="~/applications/nvim-osx64/bin/nvim"
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    alias meshlab="/Applications/meshlab.app/Contents/MacOS/meshlab"
    alias meshlabserver="/Applications/meshlab.app/Contents/MacOS/meshlabserver"
}
linux_settings () {
    alias hello="world"
}

common_settings

if test "$(uname)" = "Darwin"
then
 	# Mac installation branch
    mac_settings
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
 	# Linux installation branch
    linux_settings
fi
