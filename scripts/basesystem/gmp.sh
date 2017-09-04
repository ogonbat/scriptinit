#!/usr/bin/env bash

tar -xf /sources/gmp-6.1.2.tar.xz -C /sources

cd /sources/gmp-6.1.2

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.1.2

make
make html

make install
make install-html

cd /sources

rm -Rf gmp-6.1.2

cd /scripts