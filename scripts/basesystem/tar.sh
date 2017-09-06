#!/usr/bin/env bash

tar -xf $LFS/sources/tar-1.29.tar.xz -C $LFS/sources

cd $LFS/sources/tar-1.29

FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin


make

make DESTDIR=$LFS install
make DESTDIR=$LFS -C doc install-html docdir=/usr/share/doc/tar-1.29

cd $LFS/sources

rm -Rf tar-1.29

cd $LFS/scripts