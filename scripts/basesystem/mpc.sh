#!/usr/bin/env bash

tar -xf $LFS/sources/mpc-1.0.3.tar.gz -C $LFS/sources

cd $LFS/sources/mpc-1.0.3

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.0.3

make
make html

make DESTDIR=$LFS install
make DESTDIR=$LFS install-html

cd $LFS/sources

rm -Rf mpc-1.0.3

cd $LFS/scripts