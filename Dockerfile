#------------------------------------------------------------------------------
# Python Environment
#------------------------------------------------------------------------------
FROM continuumio/miniconda3

ENV USER=user

#------------------------------------------------------------------------------
# Linux Environment
#------------------------------------------------------------------------------
# 1.change source
COPY apt/sources.list /etc/apt/sources.list
RUN apt-get update --fix-missing -qqy && apt-get update  -qqy &&\
    apt-get install -y --no-install-recommends \
        # some basic softwares 
        sudo privoxy curl git procps zsh
        #    rm -rf /var/lib/apt/lists/*

# 2.create user
RUN export uid=1000 gid=1000 pswd=password &&\
    # may not be useful
    # apt-get clean && \
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
RUN python3 -m pip install shadowsocks  &&\
     sed -i "s|cleanup|reset|g"  /opt/conda/lib/python3.*/site-packages/shadowsocks/crypto/openssl.py


#------------------------------------------------------------------------------
# Expose ports, so you can use the exposed port when build:
# -p your_local_port:PRIVOXY_PORT
# export https_proxy="127.0.0.1:PRIVOXY_PORT"  &&  export http_proxy="127.0.0.1:PRIVOXY_PORT"
#------------------------------------------------------------------------------

ARG PRIVOXY_PORT
EXPOSE $PRIVOXY_PORT
USER $USER
COPY . /home/$USER/.Qdotfiles
WORKDIR /home/$USER
RUN cd /home/$USER/.Qdotfiles &&\
    sudo -p password su &&\
    ./scripts/bootstrap.sh

#------------------------------------------------------------------------------
#  Install softwares, below are things that maybe frequently modified
#------------------------------------------------------------------------------
ARG INSTALL_SOFTWARES=false
RUN if [ ${INSTALL_SOFTWARES} = true ]; then\
        bash ~/.Qdotfiles/scripts/cproxy daemon &&\
        export https_proxy="127.0.0.1:${PRIVOXY_PORT}" && export http_proxy="127.0.0.1:${PRIVOXY_PORT}" &&\
        # Your commands that need proxy, such as
        # curl google.com &&\
        # may not use sudo priviledge, so I comment below
        # sudo -p password su &&\
        bash ~/.Qdotfiles/scripts/install_softwares.sh \
    ;fi

CMD [".Qdotfiles/scripts/cproxy"]
