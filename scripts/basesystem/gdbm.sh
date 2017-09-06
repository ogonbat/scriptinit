#!/usr/bin/env bash

tar -xf $LFS/sources/gdbm-1.13.tar.gz -C $LFS/sources

cd $LFS/sources/gdbm-1.13

./configure --prefix=/usr \
            --disable-static \
            --enable-libgdbm-compat

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf gdbm-1.13

cd $LFS/scripts