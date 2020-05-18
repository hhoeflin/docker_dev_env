#!/bin/bash

###############
# Parameters for the installation
###############

export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export PREFIX=${HOME}/.local
export PATH=${BIN_DIR}:${PATH}
##############
# Create directories that are needed
##############
mkdir -p ${PREFIX}/bin
mkdir -p ${XDG_DATA_HOME}  # will be used as the location for the AppImage
mkdir -p ${XDG_CONFIG_HOME}

