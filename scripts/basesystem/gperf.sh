#!/usr/bin/env bash

tar -xf $LFS/sources/gperf-3.1.tar.gz -C $LFS/sources

cd $LFS/sources/gperf-3.1

./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf gperf-3.1

cd $LFS/scripts