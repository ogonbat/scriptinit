#!/usr/bin/env bash

tar -xf /sources/mpfr-3.1.5.tar.xz -C /sources

cd /sources/mpfr-3.1.5

./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-3.1.5

make
make html

make install
make install-html

cd /sources

rm -Rf mpfr-3.1.5

cd /scripts