#!/bin/bash

curl -L -o ncurses-6.1.tar.gz ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz
tar xf ncurses-6.1.tar.gz
cd ncurses-6.1
./configure --prefix=$PREFIX CXXFLAGS="-fPIC" CFLAGS="-fPIC"
make -j && make install
cd ..

