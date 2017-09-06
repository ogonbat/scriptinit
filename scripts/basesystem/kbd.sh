#!/usr/bin/env bash

tar -xf $LFS/sources/kbd-2.0.4.tar.xz -C $LFS/sources

cd $LFS/sources/kbd-2.0.4

patch -Np1 -i ../kbd-2.0.4-backspace-1.patch
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock

make

make DESTDIR=$LFS install
mkdir -v       $LFS/usr/share/doc/kbd-2.0.4
cp -R -v docs/doc/* $LFS/usr/share/doc/kbd-2.0.4

cd $LFS/sources

rm -Rf kbd-2.0.4

cd $LFS/scripts