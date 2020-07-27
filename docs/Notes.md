> **Some Unix basis**
>
> How to check a software’s existence? Taking brew as an example:
>
> ```bash
> if ! command -v  brew &> /dev/null
> then
> 		# installation process...
> fi
> ```

>How to check the current system?
>
>```bash
>if test "$(uname)" = "Darwin"
>then
>	# Mac installation branch
>	
>elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
>then
>	# Linux installation branch
>	
>fi
>```

> So, put them together:
>
> ```bash
> if ! command -v  brew &> /dev/null
> then
> 	# installation process...
>  if test "$(uname)" = "Darwin"
>  then
>   	# Mac installation branch
> 
>  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
>  then
>   	# Linux installation branch
> 
>  fi
> fi
> ```