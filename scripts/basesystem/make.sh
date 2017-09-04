#!/usr/bin/env bash

tar -xf /sources/make-4.2.1.tar.bz2 -C /sources

cd /sources/make-4.2.1

./configure --prefix=/usr

make
make install

cd /sources

rm -Rf make-4.2.1

cd /scripts