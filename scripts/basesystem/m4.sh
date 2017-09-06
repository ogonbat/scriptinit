#!/usr/bin/env bash

tar -xf $LFS/sources/m4-1.4.18.tar.xz -C $LFS/sources

cd $LFS/sources/m4-1.4.18

./configure --prefix=/usr

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf m4-1.4.18

cd $LFS/scripts