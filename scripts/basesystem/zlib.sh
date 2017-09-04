#!/usr/bin/env bash

tar -xf /sources/zlib-1.2.11.tar.xz -C /sources

cd /sources/zlib-1.2.11

./configure --prefix=/usr

make

make install

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

cd /sources

rm -Rf zlib-1.2.11

cd /scripts