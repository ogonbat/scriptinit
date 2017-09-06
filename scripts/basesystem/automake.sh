#!/usr/bin/env bash

tar -xf $LFS/sources/automake-1.15.1.tar.xz -C $LFS/sources

cd $LFS/sources/automake-1.15.1

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15.1

make
sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh
make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf automake-1.15.1

cd $LFS/scripts