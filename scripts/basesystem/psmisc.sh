#!/usr/bin/env bash

tar -xf $LFS/sources/psmisc-23.1.tar.xz -C $LFS/sources

cd $LFS/sources/psmisc-23.1

./configure --prefix=/usr

make

make DESTDIR=$LFS install

mv -v $LFS/usr/bin/fuser   $LFS/bin
mv -v $LFS/usr/bin/killall $LFS/bin

cd $LFS/sources

rm -Rf psmisc-23.1

cd $LFS/scripts