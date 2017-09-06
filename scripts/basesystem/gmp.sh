#!/usr/bin/env bash

tar -xf $LFS/sources/gmp-6.1.2.tar.xz -C $LFS/sources

cd $LFS/sources/gmp-6.1.2

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.1.2

make
make html

make DESTDIR=$LFS install
make DESTDIR=$LFS install-html

cd $LFS/sources

rm -Rf gmp-6.1.2

cd $LFS/scripts