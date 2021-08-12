<p align="center">
  <h3 align="center">QiangZiBro的dotfiles</h3>
  <p align="center">
   Developing tools and dotfiles of QiangZiBro, have fun!
  </br>
    <a href="README_zh.md">ZH</a>|<a href="README.md">EN</a>
  </p>
</p>

## Install

Let everything done, this will clone the repository and set up the softwares’ config of QiangZiBro

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/QiangZiBro/Qdotfiles/master/scripts/bootstrap.sh)"
```



## Feature

### Synchronizing and management support for multi-servers

Synchronizing configurations and installations from many softwares between mac laptop and linux servers using one repo. Each software owns a directory in root directory of the project, `install.sh` and `*.zsh` represent installation and software-wise comands.

```bash
# Update to github
qdot push 
# Update configuration from github
# Optional arg:
# -a : update all servers
qdot pull [-a]
```



### Command line http/https proxy

Http/https proxy is very important for developers, especially when there’s network limitation. The uses `ss+privoxy+docker+docker-compose` to let terminal users ultize http/https proxy easily. 

- Install

- [ ] A one-key setup command is in plan in the future, which will be like this:

```bash
proxy install
```

- Usages

```bash
# Set the env for http/https proxy
proxy on 
# Unset the env for http/https proxy
proxy off
# Test accessibility to Baidu and Google
proxy test

# Change ss proxy config assuming you've already got a
# file incluing all ss configuration
# Optional args:
# -r : upload ss file to remote
# -d : restart docker after update ss file
proxy set "116.163.14.9:45472" [-rd]
```



## Acknowledgement

[holman](https://github.com/holman)/**[dotfiles](https://github.com/holman/dotfiles)**

 [mathiasbynens](https://github.com/mathiasbynens)/**[dotfiles](https://github.com/mathiasbynens/dotfiles)**

 [Speed Up Oh-My-Zsh](https://bennycwong.github.io/post/speeding-up-oh-my-zsh/)

