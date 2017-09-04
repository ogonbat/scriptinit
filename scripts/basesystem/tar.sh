#!/usr/bin/env bash

tar -xf /sources/tar-1.29.tar.xz -C /sources

cd /sources/tar-1.29

FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin


make

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.29

cd /sources

rm -Rf tar-1.29

cd /scripts