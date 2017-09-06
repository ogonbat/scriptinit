#!/usr/bin/env bash

tar -xf $LFS/sources/less-487.tar.gz -C $LFS/sources

cd $LFS/sources/less-487

./configure --prefix=/usr --sysconfdir=/etc

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf less-487

cd $LFS/scripts