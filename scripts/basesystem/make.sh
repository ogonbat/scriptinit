#!/usr/bin/env bash

tar -xf $LFS/sources/make-4.2.1.tar.bz2 -C $LFS/sources

cd $LFS/sources/make-4.2.1

./configure --prefix=/usr

make
make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf make-4.2.1

cd $LFS/scripts