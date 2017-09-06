#!/usr/bin/env bash

tar -xf $LFS/sources/libpipeline-1.4.2.tar.gz -C $LFS/sources

cd $LFS/sources/libpipeline-1.4.2

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf libpipeline-1.4.2

cd $LFS/scripts