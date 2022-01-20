FROM ubuntu:20.04

ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN \
    apt update && \
    apt install -y \
        apt-utils \
        curl \
        dialog \
        software-properties-common \
        wget

RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -

RUN \
    apt install -y python3-pip && \
    apt install -y \ 
        bison \
        build-essential \
        clang \
        cmake \
        flex \
        g++ \
        gcc \
        gcc-multilib \
        gdb \
        gfortran \
        git \
        libomp-dev \
        nodejs \
        vim && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/*

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab
    
RUN jupyter labextension install @arbennett/base16-gruvbox-dark

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}
WORKDIR ${HOME}
RUN pip install -r ./requirements.txt

USER ${USER}

RUN mkdir -p ${HOME}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension && \
    cp ./config/themes.jupyterlab-settings ${HOME}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/. && \
    mkdir -p ${HOME}/.jupyter/lab/user-settings/@jupyterlab/terminal-extension && \
    echo '{ "fontSize": 16 }' > ${HOME}/.jupyter/lab/user-settings/@jupyterlab/terminal-extension/plugin.jupyterlab-settings

RUN install_native_kernel --user

ENV SHELL /bin/bash
