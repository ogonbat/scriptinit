#!/usr/bin/env bash

tar -xf $LFS/sources/libcap-2.25.tar.xz -C $LFS/sources

cd $LFS/sources/libcap-2.25

sed -i '/install.*STALIBNAME/d' libcap/Makefile

make
make DESTDIR=$LFS RAISE_SETFCAP=no lib=lib prefix=/usr install
chmod -v 755 $LFS/usr/lib/libcap.so

mv -v $LFS/usr/lib/libcap.so.* $LFS/lib
ln -sfv ../../lib/$(readlink $LFS/usr/lib/libcap.so) $LFS/usr/lib/libcap.so

cd $LFS/sources

rm -Rf libcap-2.25

cd $LFS/scripts