common () {
    alias sb="source ~/.zshrc"
    alias eb="nvim ~/.zshrc"
    alias fm="ranger"
}

mac () {
    alias nvim="~/applications/nvim-osx64/bin/nvim"
    alias meshlab="/Applications/meshlab.app/Contents/MacOS/meshlab"
    alias meshlab="/Applications/meshlab.app/Contents/MacOS/meshlabserver"
    alias grealpath=realpath
    alias gsed=sed
}

common
if test "$(uname)" = "Darwin"
    # mac branch
    mac
then
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
    # linux branch

fi
