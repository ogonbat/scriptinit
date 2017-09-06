#!/usr/bin/env bash

tar -xf $LFS/sources/libtool-2.4.6.tar.xz -C $LFS/sources

cd $LFS/sources/libtool-2.4.6

./configure --prefix=/usr

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf libtool-2.4.6

cd $LFS/scripts