#!/usr/bin/env bash

tar -xf /sources/libtool-2.4.6.tar.xz -C /sources

cd /sources/libtool-2.4.6

./configure --prefix=/usr

make

make install

cd /sources

rm -Rf libtool-2.4.6

cd /scripts