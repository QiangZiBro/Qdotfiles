FROM ubuntu:latest
RUN apt install sudo -y
RUN useradd -rm -d /home/qiangzibro -s /bin/bash  -G sudo -u 1001 qiangzibro
USER qiangzibro
WORKDIR /home/qiangzibro
ADD . .Qdotfiles
