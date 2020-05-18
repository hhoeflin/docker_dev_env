#!/bin/bash

curl -L -o zsh-5.8.tar.xz https://sourceforge.net/projects/zsh/files/zsh/5.8/zsh-5.8.tar.xz/download
tar xf zsh-5.8.tar.xz
cd zsh-5.8
./configure --prefix="$PREFIX" --with-tcsetpgrp \
    CPPFLAGS="-I$PREFIX/include" \
    LDFLAGS="-L$PREFIX/lib"
make -j && make install
cd ..

cp zshrc $HOME/.zshrc
cp p10k.zsh $HOME/.p10k.zsh

ZPLUG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME

# need to source init.zsh as it is not read in non-interactive mode
zsh -c 'source ~/.zshrc && zplug install'
