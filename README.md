<p align="center">
  <h3 align="center">QiangZiBro的dotfiles</h3>
  <p align="center">
   Development tools and dotfiles of QiangZiBro, supporting mac and ubuntu in the same time.
  </br>
    <a href="README_zh.md">ZH</a>|<a href="README.md">EN</a>
  </p>
</p>

Wanna have a try? Just copy this command to your terminal, Qdotfiles will be installed and setup on your mac or linux.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/QiangZiBro/Qdotfiles/main/scripts/bootstrap.sh)"
```



## Getting started

Fork this repo, change name `QiangZiBro` to `your_github_username`  in below command

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/your_github_username/Qdotfiles/main/scripts/bootstrap.sh)"
```

Make changes, and commit to your repository

```
qdot backup 
qdot push -m "changes" -t [main|dev|HEAD]
```

Proxy utilities in Qdotfiles

```bash
proxy [on|off|up|down|status|restart|cmd|set|which|test]
```



## Feature

### Synchronizing support for multi-servers

You can synchronize multiple servers by including ssh configuration in`.env` 

```
SERVERS="l0 l1 l2 l3 l4 l5 l6"
```

then you can manage multiple servers based on this file, e.g., update Qdotfiles of all servers from github:

```bash
qdot pull -r
```

Each software owns a directory in root directory of the project, `install.sh` and `*.zsh` represent installation and software-wise comands.

### Command line http/https proxy

Http/https proxy is very important for developers, especially when there’s network limitation. We use `ss+privoxy+docker+docker-compose` to let terminal users ultize http/https proxy easily. 

- Install


To get command line run in your computer, first ensure your `docker` and `docker-compose` are setup correctly

```bash
bash docker/install.sh
```

And then using command below, which builds the container in the first time and run container forever in your computer

```bash
proxy up
# equals 
# docker-compose up -d
```

To get the ss service stop, run

```bash
proxy down
# equals 
# docker-compose down
```



- Usages

```bash
# Set the env for http/https proxy
proxy on 
# Unset the env for http/https proxy
proxy off
# Test accessibility to Baidu and Google
proxy test
```

Find ss config file automatically if you have [ShadowsocksX-NG](https://github.com/shadowsocks/ShadowsocksX-NG) installed on your mac.

```bash
proxy set
```

Change ss proxy config assuming you've already got a file incluing all ss configuration

```bash
# Optional args:
# -r : upload ss file to remote
# -d : restart docker after update ss file
proxy set "116.163.14.9:45472" [-rd]
```



### Command line support to manage dotfiles

We have a command named `qdot` or `q` to premote things to be done instantly, you can use a single command setup config in this repo to your computer

```bash
q b # qdot bootstrap
```

or use  `push`  or  `pull`  to remote git server

```bash
q [push|pull] [-m message -t <refspec>]
```

### Other

- Setting various of softwares/configuration for a multi-users ubuntu system [here](scripts/init_a_fresh_ubuntu)



## Updates

- 2021-08-18 

  - Use `.env` to maintain config with docker and this project

  - Use `proxy set`  to find ss config file automatically if you have [ShadowsocksX-NG](https://github.com/shadowsocks/ShadowsocksX-NG) installed on your mac.

  -  `proxy on (mac|linux|9090)` to set port

  - `qtool ip` to get current machine’s ip quickly 

    

## Acknowledgement

[holman](https://github.com/holman)/**[dotfiles](https://github.com/holman/dotfiles)**

 [mathiasbynens](https://github.com/mathiasbynens)/**[dotfiles](https://github.com/mathiasbynens/dotfiles)**

 [Speed Up Oh-My-Zsh](https://bennycwong.github.io/post/speeding-up-oh-my-zsh/)

