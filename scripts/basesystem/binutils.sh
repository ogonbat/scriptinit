#!/usr/bin/env bash

tar -xf /sources/binutils-2.29.tar.bz2 -C /sources

cd /sources/binutils-2.29

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

make tooldir=/usr install

cd /sources

rm -Rf binutils-2.29

cd /scripts