# 命令行冲浪配置

有些时候必须要科学地使用命令行，比如用`git`从github上克隆项目，否则一些配置安装要等个几天几夜。笔者不喜欢点击网页的下载按钮，毕竟，命令行下载那么方便！

```bash
# 注：提前装好了python 的环境
# 1.前期配置
pip install shadowsocks
sudo apt install privoxy
sed -i "s|cleanup|reset|g" /usr/miniconda3/lib/python3.7/site-packages/shadowsocks/crypto/openssl.py # openssl bug，换一下变量名就可以了
# 2.接着配置privoxy 略
sudo systemctl start privoxy
# 3.启动
sslocal -c ss.json  # 配置文件
export http_proxy=127.0.0.1:1087
export https_proxy=127.0.0.1:1087
# done
```

启动的方式`scripts/cproxy`写好了，配置文件放在对应位置即可。
