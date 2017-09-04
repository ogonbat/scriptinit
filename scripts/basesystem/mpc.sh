#!/usr/bin/env bash

tar -xf /sources/mpc-1.0.3.tar.gz -C /sources

cd /sources/mpc-1.0.3

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.0.3

make
make html

make install
make install-html

cd /sources

rm -Rf mpc-1.0.3

cd /scripts