#!/usr/bin/env bash

tar -xf $LFS/sources/mpfr-3.1.5.tar.xz -C $LFS/sources

cd $LFS/sources/mpfr-3.1.5

./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-3.1.5

make
make html

make DESTDIR=$LFS install
make DESTDIR=$LFS install-html

cd $LFS/sources

rm -Rf mpfr-3.1.5

cd $LFS/scripts