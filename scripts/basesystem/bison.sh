#!/usr/bin/env bash

tar -xf /sources/bison-3.0.4.tar.xz -C /sources

cd /sources/bison-3.0.4

./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.0.4

make

make install

cd /sources

rm -Rf bison-3.0.4

cd /scripts