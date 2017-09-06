#!/usr/bin/env bash

tar -xf $LFS/sources/gzip-1.8.tar.xz -C $LFS/sources

cd $LFS/sources/gzip-1.8

./configure --prefix=/usr

make

make DESTDIR=$LFS install
mv -v $LFS/usr/bin/gzip $LFS/bin
cd $LFS/sources

rm -Rf gzip-1.8

cd $LFS/scripts