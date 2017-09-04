#!/usr/bin/env bash

tar -xf /sources/gdbm-1.13.tar.gz -C /sources

cd /sources/gdbm-1.13

./configure --prefix=/usr \
            --disable-static \
            --enable-libgdbm-compat

make

make install

cd /sources

rm -Rf gdbm-1.13

cd /scripts