common() {
}
linux() {
}

mac() {
}

common
if
  test "$(uname)" = "Darwin"
  # mac branch
  mac
then
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
  # linux branch
  linux

fi
