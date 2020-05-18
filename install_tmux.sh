#!/bin/bash
##############
# TMUX
##############
TMUX_VERSION=3.0a

TMUX_TARGET=tmux-${TMUX_VERSION}-x86_64.AppImage
TMUX_CONFIG=${XDG_CONFIG_HOME}/tmux
mkdir -p ${TMUX_CONFIG}
curl -L https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}-x86_64.AppImage -o ${TMUX_TARGET}
chmod a+x ${TMUX_TARGET}
./${TMUX_TARGET} --appimage-extract && mv squashfs-root ${XDG_DATA_HOME}/tmux-appdir
ln -s ${XDG_DATA_HOME}/tmux-appdir/AppRun  ${PREFIX}/bin/tmux
rm ${TMUX_TARGET}

# copy tmux.conf
cp config/tmux/tmux.conf ${TMUX_CONFIG}/tmux.conf

# install the tmux plugin manager (tpm)
export TMUX_PLUGIN_MANAGER_PATH=${XDG_CONFIG_HOME}/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ${TMUX_PLUGIN_MANAGER_PATH}/tpm
${TMUX_PLUGIN_MANAGER_PATH}/tpm/bin/install_plugins

