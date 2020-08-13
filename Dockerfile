ARG version=20.04
FROM ubuntu:$version
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get update \
    && apt-get install -y curl \
        git \
        build-essential \
        unzip \
        locales \ 
        python \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set the the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN useradd -ms /bin/bash devenv
USER devenv
WORKDIR /home/devenv

# set the home directory
ENV HOME=/home/devenv
ENV XDG_CONFIG_HOME=${HOME}/.config \
    XDG_DATA_HOME=${HOME}/.local/share \
    PREFIX=${HOME}/.local \
    PATH=${HOME}/.local/bin:${PATH}

# copy all files we need for setting up and run the setup script
RUN mkdir -p /home/devenv/setup
COPY --chown=devenv config setup/config
WORKDIR /home/devenv/setup
# initialization
COPY --chown=devenv init_vars.sh init_vars.sh
RUN chmod +x init_vars.sh && ./init_vars.sh
# TMUX
COPY --chown=devenv install_tmux.sh install_tmux.sh
RUN chmod +x install_tmux.sh && ./install_tmux.sh
# ZSH
COPY --chown=devenv install_ncurses.sh install_ncurses.sh
RUN chmod +x install_ncurses.sh && ./install_ncurses.sh
COPY --chown=devenv install_zsh.sh install_zsh.sh
COPY --chown=devenv zshrc p10k.zsh ./
RUN chmod +x install_zsh.sh && ./install_zsh.sh
# Neovim
COPY --chown=devenv install_neovim.sh install_neovim.sh
RUN chmod +x install_neovim.sh && ./install_neovim.sh
# CLI tools
COPY --chown=devenv install_cli.sh install_cli.sh
RUN chmod +x install_cli.sh && ./install_cli.sh
WORKDIR /home/devenv

# need to set the correct terminal
ENV TERM screen-256color

RUN chmod a+rwX -R *

