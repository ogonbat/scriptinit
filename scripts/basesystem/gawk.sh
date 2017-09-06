#!/usr/bin/env bash

tar -xf $LFS/sources/gawk-4.1.4.tar.xz -C $LFS/sources

cd $LFS/sources/gawk-4.1.4

./configure --prefix=/usr

make

make DESTDIR=$LFS install
mkdir -v $LFS/usr/share/doc/gawk-4.1.4
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} $LFS/usr/share/doc/gawk-4.1.4

cd $LFS/sources

rm -Rf gawk-4.1.4

cd $LFS/scripts