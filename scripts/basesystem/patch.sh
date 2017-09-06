#!/usr/bin/env bash

tar -xf $LFS/sources/patch-2.7.5.tar.xz -C $LFS/sources

cd $LFS/sources/patch-2.7.5

./configure --prefix=/usr

make
make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf patch-2.7.5

cd $LFS/scripts