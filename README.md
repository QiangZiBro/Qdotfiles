<p align="center">
  <img src="https://gitee.com/qiangzibro/uPic/raw/master/uPic/icon.jpg" alt="icon" style="zoom:50%;" />
  <h3 align="center">QiangZiBro的dotfiles</h3>
  <p align="center">
    点文件(dotfiles)狭义上指unix系统上以点开头的配置文件，这个仓库是我的点文件合集。
    <br />
    同时我还加入了常用软件安装脚本，并让其跑在了docker里面。使用前请先看看哪些文件生效了，切勿盲目使用！虽欢迎你使用，但自己承担风险！
​       <br />
    <a href="README_en.md">EN</a>
  </p>
</p>



> 2020.12.16 update: 本仓库文档落后于程序，请按需直接参考对应脚本。

## 前言

还记得大学时玩linux，频繁更系统的我为了能在初始新系统时节省时间，写了一系列脚本。这些脚本从功能上和内容上都比较简陋——也就是进行一些初始化配置，并把自己的vim配置文件通过脚本放到对应的位置上。后来看到[韦大佬](https://www.zhihu.com/people/skywind3000)的文章[提高效率从编写 init.sh 开始](https://zhuanlan.zhihu.com/p/50080614)，才体悟到管理好一份个人的dotfiles有多么重要。于是顺着这篇文章的思想，我开始构建自己的dotfiles。虽然借鉴了一些项目，但仍水平有限，写得一般。因此，这份说明文档更像是一个总结，讲讲我是怎样构建自己的dotfiles的。

在这份配置中希望解决几个痛点：

- **中国开发者总所周知的网络问题** 对我自己常使用的apt、docker、pip、conda进行自动一键换到国内源，对下载有困难的比如git、wget、pytorch官方包使用命令行代理

- **多端同步** 目前我在linux上和mac上终端通用一个配置，这一切得益于这个dotfiles仓库

- **新机器快速初始化** 通过一个bootstrap.sh脚本即可完成配置工作

  

## 用法速记表

按使用频率由高到底从前到后

### 1 立即从一台unix机器上设置Qdotfiles

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/QiangZiBro/Qdotfiles/master/scripts/bootstrap.sh)"
```

### 2 仅克隆项目

```bash
git clone https://github.com/QiangZiBro/Qdotfiles ~/.Qdotfiles && cd ~/.Qdotfiles
```

### 3 配置命令行代理

像apt、docker、pip、conda都可以通过上一个条命令一键换回国内源，但对下载有困难的比如git、wget、pytorch官方包，需要使用命令行代理

- 第一步：把`ss.json`放在` ss/ `文件里

- 第二步：输入`dcd`可运行docker镜像到后台
- 第三步：`proxy start`开启代理，这个命令会设置http、https的代理端口，并设置git的http代理

### 4 在docker里体验我的配置

```bash
docker-compose build --build-arg INSTALL_SOFTWARES=true
docker-compose exec Qlinux zsh
```

### 5 更多

### docker

| 命令  | 意义                 |
| ----- | -------------------- |
| dcu   | docker-compose up    |
| dcd   | docker-compose up -d |
| dce   | docker-compose exec  |
| ddown | docker-compose down  |

### zsh

| 命令  | 意义                              |
| ----- | --------------------------------- |
| eb    | nvim ~/.zshrc                     |
| ei    | nvim ~/.Qdotfiles/scripts/init.sh |
| cq    | cd ~/.Qdotfiles/                  |
| proxy | [ss/proxy.zsh](ss/proxy.zsh)      |

### 脚本功能

| 文本                                                         | 意义                               |
| ------------------------------------------------------------ | ---------------------------------- |
| [ss/update_ss.*](ss/update_ss.py)                            | 通过ip从一堆配置中选取一份配置文件 |
| [scripts/bootstrap.sh](scripts/bootstrap.sh)                 | 将配置部署到机器上                 |
| [scripts/backup.sh](scripts/backup.sh)                       | 备份脚本                           |
| [scripts/setup_ss_privoxy_port.sh](scripts/setup_ss_privoxy_port.sh) | 更换ss端口和privoxy端口            |
| [scripts/cproxy](scripts/cproxy)                             | 开启命令行代理                     |
| [scripts/init.sh](scripts/init.sh)                           | zsh配置的入口（不要运行）          |

## 实现过程

### 我需要什么

- 这些软件的 *配置* 和 *安装*方式
  - python、conda
  - zsh
  - neovim
  - docker
  - ...
- 我用的包管理器和终端需要 *配镜像源* 和 *代理*
- 移植到新的机器上要尽可能地快
- 要能灵活管理各种配置文件

### 我是怎么解决的

- 为每个软件建立一个文件夹，里面放上其配置和安装脚本

- 为apt、pip、conda配置镜像源，使用docker配置命令行代理

- 把配置的克隆和部署写到一个` bootstrap.sh`文件上，curl 下来一执行，一句话的事情

  ```bash
  # A start of configuration in a new machine (will clone the project in `~/.Qdotfiles`)
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/QiangZiBro/Qdotfiles/master/scripts/bootstrap.sh)"
  ```

- 将备份工作通过一个备份脚本[backup.sh](./scripts/backup.sh)来完成

  ```bash
  ~/.Qdotfiles/scripts/backup
  ```


- 将zsh的环境变量模块化，`init.sh` 用仓库托管起来，而本地 `~/.zshrc` 末尾加一句话：

  ```text
  source ~/.Qdotfiles/scripts/init.sh
  ```

  即可

- 命令行代理

原理：使用`privoxy+shadowsocks`的方法对http进行代理。[cproxy](./scripts/cproxy)脚本完成这个功能。接着在终端输入`proxy start`即可开启使用。

但配置和运行的过程总是略显繁琐，于是，我将整个过程打包成docker，在项目主目录下，输入下面语句即可完成编译

```bash
docker-compose build --build-arg INSTALL_SOFTWARES=false
```

再次输入

```bash
docker-compose up # 运行在前台，再加 -d 运行在后台
```

就在电脑上一个端口开启了服务，接着在终端输入

```bash
proxy start
```

即可使用命令行代理，试一试

```bash
curl -I www.google.com
```

- 在docker里面体验我的dotfiles

```bash
# 1.克隆Qdotfiles
git clone https://github.com/QiangZiBro/Qdotfiles ~/.Qdotfiles && cd ~/.Qdotfiles
# 2.把ss.json放在ss/文件里

# 3.编译镜像
docker-compose build --build-arg INSTALL_SOFTWARES=true

# 4.进入
dce Qlinux zsh
```



## TODO

- [ ] 移除不需要的内容
- [ ] 整理安装软件顺序，现在在新机器上还是不能一键下载好软件



## 参考

[1] [holman](https://github.com/holman)/**[dotfiles](https://github.com/holman/dotfiles)**

[2] [mathiasbynens](https://github.com/mathiasbynens)/**[dotfiles](https://github.com/mathiasbynens/dotfiles)**

[3] [Speed Up Oh-My-Zsh](https://bennycwong.github.io/post/speeding-up-oh-my-zsh/)

