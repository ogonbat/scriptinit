#!/usr/bin/env bash

tar -xf /sources/gzip-1.8.tar.xz -C /sources

cd /sources/gzip-1.8

./configure --prefix=/usr

make

make install
mv -v /usr/bin/gzip /bin
cd /sources

rm -Rf gzip-1.8

cd /scripts