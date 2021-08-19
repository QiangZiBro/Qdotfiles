if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo linux install
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo darwin install
elif [[ "$OSTYPE" == "cygwin" ]]; then
  echo cygwin install
elif [[ "$OSTYPE" == "msys" ]]; then
  echo msys install
elif [[ "$OSTYPE" == "win32" ]]; then
  echo win32 install
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  echo freebsd install
else
  echo not supported for current system
fi
