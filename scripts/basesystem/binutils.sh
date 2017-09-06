#!/usr/bin/env bash

tar -xf $LFS/sources/binutils-2.29.tar.bz2 -C $LFS/sources

cd $LFS/sources/binutils-2.29

expect -c "spawn ls"

mkdir -v build
cd       build


../configure --prefix=/usr       \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --with-system-zlib


make tooldir=/usr

make DESTDIR=$LFS tooldir=/usr install

cd $LFS/sources

rm -Rf binutils-2.29

cd $LFS/scripts