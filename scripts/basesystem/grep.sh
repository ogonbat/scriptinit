#!/usr/bin/env bash

tar -xf $LFS/sources/grep-3.1.tar.xz -C $LFS/sources

cd $LFS/sources/grep-3.1

./configure --prefix=/usr --bindir=/bin

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf grep-3.1

cd $LFS/scripts