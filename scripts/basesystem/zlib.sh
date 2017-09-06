#!/usr/bin/env bash

tar -xf $LFS/sources/zlib-1.2.11.tar.xz -C $LFS/sources

cd $LFS/sources/zlib-1.2.11

./configure --prefix=/usr

make

make DESTDIR=$LFS install

mv -v $LFS/usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) $LFS/usr/lib/libz.so

cd $LFS/sources

rm -Rf zlib-1.2.11

cd $LFS/scripts