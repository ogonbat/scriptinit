#!/usr/bin/env bash

tar -xf $LFS/sources/tar-1.29.tar.xz -C $LFS/sources

cd $LFS/sources/tar-1.29

./configure --prefix=/tools

make

make install

cd $LFS/sources

rm -Rf tar-1.29

cd $MRX