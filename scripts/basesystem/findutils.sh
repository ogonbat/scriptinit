#!/usr/bin/env bash

tar -xf $LFS/sources/findutils-4.6.0.tar.gz -C $LFS/sources

cd $LFS/sources/findutils-4.6.0

sed -i 's/test-lock..EXEEXT.//' tests/Makefile.in

./configure --prefix=/usr --localstatedir=/var/lib/locate

make

make DESTDIR=$LFS install
mv -v $LFS/usr/bin/find $LFS/bin
sed -i 's|find:=${BINDIR}|find:=/bin|' $LFS/usr/bin/updatedb

cd $LFS/sources

rm -Rf findutils-4.6.0

cd $LFS/scripts