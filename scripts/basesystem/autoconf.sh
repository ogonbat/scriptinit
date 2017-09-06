#!/usr/bin/env bash

tar -xf $LFS/sources/autoconf-2.69.tar.xz -C $LFS/sources

cd $LFS/sources/autoconf-2.69

./configure --prefix=/usr

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf autoconf-2.69

cd $LFS/scripts