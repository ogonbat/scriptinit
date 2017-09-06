#!/usr/bin/env bash

tar -xf $LFS/sources/groff-1.22.3.tar.gz -C $LFS/sources

cd $LFS/sources/groff-1.22.3

PAGE=A4 ./configure --prefix=/usr

make -j1

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf groff-1.22.3

cd $LFS/scripts