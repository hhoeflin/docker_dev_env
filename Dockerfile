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
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash docker
USER docker
WORKDIR /home/docker

# set the home directory
ENV HOME=/home/docker
ENV XDG_CONFIG_HOME=${HOME}/.config \
    XDG_DATA_HOME=${HOME}/.local/share \
    PREFIX=${HOME}/.local \
    PATH=${HOME}/.local/bin:${PATH}

# copy all files we need for setting up and run the setup script
RUN mkdir -p /home/docker/setup
COPY --chown=docker config setup/config
WORKDIR /home/docker/setup
# initializatoin
COPY --chown=docker init_vars.sh init_vars.sh
RUN chmod +x init_vars.sh && ./init_vars.sh
# TMUX
COPY --chown=docker install_tmux.sh install_tmux.sh
RUN chmod +x install_tmux.sh && ./install_tmux.sh
# ZSH
COPY --chown=docker install_ncurses.sh install_ncurses.sh
RUN chmod +x install_ncurses.sh && ./install_ncurses.sh
COPY --chown=docker install_zsh.sh install_zsh.sh
COPY --chown=docker zshrc p10k.zsh ./
RUN chmod +x install_zsh.sh && ./install_zsh.sh
# Neovim
COPY --chown=docker install_neovim.sh install_neovim.sh
RUN chmod +x install_neovim.sh && ./install_neovim.sh
# CLI tools
COPY --chown=docker install_cli.sh install_cli.sh
RUN chmod +x install_cli.sh && ./install_cli.sh
WORKDIR /home/docker

#  && chown -R linuxbrew: /home/linuxbrew/.linuxbrew \
#  && chmod -R g+w,o-w /home/linuxbrew/.linuxbrew

# now install the brew apps that we want
#RUN brew install bat diff-so-fancy ripgrep exa fd fzf the_silver_searcher python htop \
#    node neovim ctags yarn jesseduffield/lazygit/lazygit
#ENV PATH=$HOME/.linuxbrew/opt/python/libexec/bin:$PATH
#RUN pip install visidata

# Default powerline10k theme, no plugins installed
#ENV TERM=screen-256color
#RUN sh -c "$(curl https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" -- \
#    -p history-substring-search \
#    -p git \
#    -p https://github.com/zsh-users/zsh-autosuggestions \
#    -p https://github.com/zsh-users/zsh-completions

# set the configuration files
#COPY .p10k.zsh .zshrc $HOME/
# set the correct timezone for europe
#RUN rm -f /etc/localtime && \
#    ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime

# need to do the setup for neovim, including my own files
# at first need to ensure init.nvim only has the plug commands, otherwise there are errors
#COPY .config/nvim/* $HOME/.config/nvim/
# for python language server install for coc-python
# https://github.com/microsoft/python-language-server/issues/1698
# to find out what the latest language server is, go into nvim, open a python file and execute
# CocCommand python.upgradePythonLanguageServer
#ENV MPYLS_VERSION=0.5.45
#RUN curl -OJ https://pvsc.azureedge.net/python-language-server-stable/Python-Language-Server-linux-x64.$MPYLS_VERSION.nupkg && \
#    mkdir -p .config/coc/extensions/coc-python-data && \
#    unzip Python-Language-Server-linux-x64.$MPYLS_VERSION.nupkg -d .config/coc/extensions/coc-python-data/languageServer-$MPYLS_VERSION && \
#    rm Python-Language-Server-linux-x64.$MPYLS_VERSION.nupkg && \
#    chmod +x .config/coc/extensions/coc-python-data/languageServer-$MPYLS_VERSION/Microsoft.Python.LanguageServer
#RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && \
#    mv .config/nvim/init.vim .config/nvim/init.save && \
#    sed /'call CocBuildUpdate()'/q .config/nvim/init.save > .config/nvim/init.vim && \
#    nvim +PlugInstall +qa > /dev/null && \
#    mv .config/nvim/init.save .config/nvim/init.vim && \
#    pip install pynvim flake8 mypy pydocstyle



