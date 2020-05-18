#!/bin/bash

# install bat
BAT_VERSION=0.15.1
curl -LO https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz
tar -xf bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz
cp bat-v${BAT_VERSION}-x86_64-unknown-linux-musl/bat ${PREFIX}/bin
chmod +x ${PREFIX}/bin/bat

# prettyping
curl -LO https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
chmod +x prettyping
mv prettyping ${PREFIX}/bin

# fzf; already installed in vim, make binaries available
ln -s ${XDG_CONFIG_HOME}/nvim/plugins/fzf/bin/fzf ${PREFIX}/bin/fzf
ln -s ${XDG_CONFIG_HOME}/nvim/plugins/fzf/bin/fzf-tmux ${PREFIX}/bin/fzf-tmux

# htop
HTOP_VERSION=2.2.0
curl -LO http://hisham.hm/htop/releases/${HTOP_VERSION}/htop-${HTOP_VERSION}.tar.gz
tar -xf htop-${HTOP_VERSION}.tar.gz
cd htop-${HTOP_VERSION}
./configure --prefix=$PREFIX --disable-unicode \
    CPPFLAGS="-I$PREFIX/include" \
    LDFLAGS="-L$PREFIX/lib"
make -j && make install
cd ..

# diff so fancy
git clone https://github.com/so-fancy/diff-so-fancy.git ${XDG_DATA_HOME}/diff-so-fancy
chmod +x ${XDG_DATA_HOME}/diff-so-fancy/diff-so-fancy
ln -s ${XDG_DATA_HOME}/diff-so-fancy/diff-so-fancy ${PREFIX}/bin/diff-so-fancy

# exa
EXA_VERSION=0.9.0
curl -LO https://github.com/ogham/exa/releases/download/v${EXA_VERSION}/exa-linux-x86_64-${EXA_VERSION}.zip
unzip exa-linux-x86_64-${EXA_VERSION}.zip
mv exa-linux-x86_64 ${PREFIX}/bin/exa
chmod +x ${PREFIX}/bin/exa

# fd
FD_VERSION=8.0.0
curl -LO https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-musl.tar.gz
tar -xf fd-v${FD_VERSION}-x86_64-unknown-linux-musl.tar.gz
cp fd-v${FD_VERSION}-x86_64-unknown-linux-musl/fd ${PREFIX}/bin
chmod +x ${PREFIX}/bin/fd

### NNN
NNN_VERSION=3.1
curl -LO https://github.com/jarun/nnn/releases/download/v${NNN_VERSION}/nnn-static-${NNN_VERSION}.x86-64.tar.gz
tar -xf nnn-static-${NNN_VERSION}.x86-64.tar.gz
mv nnn-static ${PREFIX}/bin/nnn

### ripgrep
RG_VERSION=12.1.0
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz
tar -xf ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz
mv ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl ${XDG_DATA_HOME}
ln -s ${XDG_DATA_HOME}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg ${PREFIX}/bin/rg
chmod +x ${PREFIX}/bin/rg
