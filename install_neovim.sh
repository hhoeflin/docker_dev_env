#!/bin/bash
# need to do the setup for neovim, including my own files
# at first need to ensure init.nvim only has the plug commands, otherwise there are errors
cp -r config/nvim ${HOME}/.config/nvim

# now need to install neovim itself
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod a+x nvim.appimage
./nvim.appimage --appimage-extract && mv squashfs-root ${XDG_DATA_HOME}/nvim-appdir
ln -s ${XDG_DATA_HOME}/nvim-appdir/AppRun ${PREFIX}/bin/nvim

# nodejs
NODE_VERSION=12.16.3
NODE_DISTRO=linux-x64
curl -LO https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-$NODE_DISTRO.tar.xz
tar -xf node-v$NODE_VERSION-$NODE_DISTRO.tar.xz && \
    mv node-v$NODE_VERSION-$NODE_DISTRO ${XDG_DATA_HOME}/nodejs
ln -s ${XDG_DATA_HOME}/nodejs/bin/node ${PREFIX}/bin/node
ln -s  ${XDG_DATA_HOME}/nodejs/bin/node ${PREFIX}/bin/nodejs
ln -s  ${XDG_DATA_HOME}/nodejs/bin/npm ${PREFIX}/bin/npm
ln -s  ${XDG_DATA_HOME}/nodejs/bin/npx ${PREFIX}/bin/npx
# we also need yarn
curl -LO https://github.com/yarnpkg/yarn/releases/download/v1.22.4/yarn-v1.22.4.tar.gz
tar -xf yarn-v1.22.4.tar.gz && mv yarn-v1.22.4 ${XDG_DATA_HOME}/yarn
ln -s ${XDG_DATA_HOME}/yarn/bin/yarn ${PREFIX}/bin/yarn

# for python language server install for coc-python
# https://github.com/microsoft/python-language-server/issues/1698
# to find out what the latest language server is, go into nvim, open a python file and execute
# CocCommand python.upgradePythonLanguageServer
MPYLS_VERSION=0.5.50
curl -OL https://pvsc.azureedge.net/python-language-server-stable/Python-Language-Server-linux-x64.$MPYLS_VERSION.nupkg
mkdir -p ${XDG_CONFIG_HOME}/coc/extensions/coc-python-data
unzip Python-Language-Server-linux-x64.$MPYLS_VERSION.nupkg -d ${XDG_COFNIG_HOME}/coc/extensions/coc-python-data/languageServer-$MPYLS_VERSION
rm Python-Language-Server-linux-x64.$MPYLS_VERSION.nupkg
chmod +x i${XDG_CONFIG_HOME}/coc/extensions/coc-python-data/languageServer-$MPYLS_VERSION/Microsoft.Python.LanguageServer

# make vim-plug available and run it
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mv ${XDG_CONFIG_HOME}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/init.save
sed /'call CocBuildUpdate()'/q ${XDG_CONFIG_HOME}/nvim/init.save > ${XDG_CONFIG_HOME}/nvim/init.vim
nvim +PlugInstall +qa 
mv ${XDG_CONFIG_HOME}/nvim/init.save ${XDG_CONFIG_HOME}/nvim/init.vim
