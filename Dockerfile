#------------------------------------------------------------------------------
# Python Environment
#------------------------------------------------------------------------------
FROM continuumio/miniconda3

ENV USER=qiangzibro

#------------------------------------------------------------------------------
# Linux Environment
#------------------------------------------------------------------------------
# 1.change source
COPY apt/sources.list /etc/apt/sources.list
RUN apt-get update --fix-missing -qqy && apt-get update  -qqy &&\
    apt-get install -y --no-install-recommends \
        # some basic softwares 
        sudo privoxy curl git procps 
# 2.create user
RUN export uid=1000 gid=1000 pswd=password &&\
    apt-get clean && \
    groupadd -g $gid $USER && \
    useradd -g $USER -G sudo -m -s /bin/bash $USER && \
    # -m : create home dir if not exists
    echo "$USER:$pswd" | chpasswd && \
    mkdir -p /home/$USER && \
    mkdir -p /etc/sudoers.d && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER && \
    chown ${uid}:${gid} -R /home/$USER 

#------------------------------------------------------------------------------
# Python Environment
#------------------------------------------------------------------------------
#Change to china source, install privoxy and shadowsocks and fix ssl bug
COPY .pip /root/.pip
RUN python3 -m pip install shadowsocks &&\
    sed -i "s|cleanup|reset|g"  /opt/conda/lib/python3.7/site-packages/shadowsocks/crypto/openssl.py


#------------------------------------------------------------------------------
# Expose ports, so you can use the exposed port when build:
# -p your_local_port:8118
# export https_proxy="127.0.0.1:your_local_port"  &&  export http_proxy="127.0.0.1:your_local_port"
#------------------------------------------------------------------------------
EXPOSE 8118


#------------------------------------------------------------------------------
#  Install softwares, below are things that maybe frequently modified
#------------------------------------------------------------------------------
RUN apt-get update  -qqy
RUN apt-get install -y --no-install-recommends \
        tmux zsh
#    rm -rf /var/lib/apt/lists/*

USER $USER
COPY . /home/$USER/.Qdotfiles
WORKDIR /home/$USER

RUN cd /home/$USER/.Qdotfiles &&\
    sudo -p password su &&\
    ./scripts/bootstrap.sh

RUN bash ~/.Qdotfiles/scripts/cproxy daemon &&\
    export https_proxy="127.0.0.1:8118" && export http_proxy="127.0.0.1:8118" &&\
    # Your command that need proxy, such as
    # curl google.com &&\
    # sudo -p password su &&\
    bash ~/.Qdotfiles/scripts/install_softwares.sh

CMD [".Qdotfiles/scripts/cproxy"]
