As an unix enthusiast, I want to make my work flow easier by collecting various configuration files, and make the configuration and installation process automatic. 

> **Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

## Philosophy

- Because of  reasons as we know in China, some softwares may be slow to download. Thus, each software should be download as fast as possible(Changing sources to which of china etc.)

- The configuration can be used in both real machines(Mac, Linux) and docker.

## Softwares

When running `bash scripts/bootstrap.sh`, the script will check the existence of softwares below, and install what is not exsited.


1. Miniconda
2. Tmux
3. Shadowsocks
4. Privoxy
5. Neovim
6. Ranger
7. Homebrew


## Good Reference

1. https://github.com/skywind3000/awesome-cheatsheets
