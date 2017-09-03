#!/usr/bin/env bash

tar -xf $LFS/sources/coreutils-8.27.tar.xz -C $LFS/sources

cd $LFS/sources/coreutils-8.27

./configure --prefix=/tools --enable-install-program=hostname

make

make install

cd $LFS/sources

rm -Rf coreutils-8.27

cd $MRX