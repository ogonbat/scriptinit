#!/usr/bin/env bash

tar -xf $LFS/sources/diffutils-3.6.tar.xz -C $LFS/sources

cd $LFS/sources/diffutils-3.6

./configure --prefix=/usr

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf diffutils-3.6

cd $LFS/scripts