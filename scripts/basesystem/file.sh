#!/usr/bin/env bash

tar -xf $LFS/sources/file-5.31.tar.gz -C $LFS/sources

cd $LFS/sources/file-5.31

./configure --prefix=/usr

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf file-5.31

cd $LFS/scripts