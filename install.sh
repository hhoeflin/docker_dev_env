#!/bin/bash

#############################################
# This script is intended to install the entire
# development configuration from scratch
#############################################

###############
# Depedencies:
# - curl: Used to download the apps 
# - git: needed to clone repos for installs
###############

###############
# Parameters for the installation
###############

export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
# versions of the programs
TMUX_VERSION=3.0a


##############
# Create directories that are needed
##############
BIN_DIR=${HOME}/.local/bin
export PATH=${BIN_DIR}:${PATH}

mkdir -p ${BIN_DIR}
mkdir -p ${XDG_DATA_HOME}  # will be used as the location for the AppImage
mkdir -p ${XDG_CONFIG_HOME}

##############
# TMUX
##############
TMUX_TARGET=tmux-${TMUX_VERSION}-x86_64.AppImage
TMUX_CONFIG=${XDG_CONFIG_HOME}/tmux
mkdir -p ${TMUX_CONFIG}
curl -L https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}-x86_64.AppImage -o ${TMUX_TARGET}
chmod a+x ${TMUX_TARGET}
./${TMUX_TARGET} --appimage-extract && mv squashfs-root ${XDG_DATA_HOME}/tmux-appdir
ln -s ${XDG_DATA_HOME}/tmux-appdir/AppRun  ${BIN_DIR}/tmux
rm ${TMUX_TARGET}

# copy tmux.conf
cp config/tmux/tmux.conf ${TMUX_CONFIG}/tmux.conf

# install the tmux plugin manager (tpm)
PATH=${BIN_DIR}:${PATH}
export TMUX_PLUGIN_MANAGER_PATH=${XDG_CONFIG_HOME}/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ${TMUX_PLUGIN_MANAGER_PATH}/tpm
${TMUX_PLUGIN_MANAGER_PATH}/tpm/bin/install_plugins

