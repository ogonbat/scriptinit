#!/usr/bin/env bash

tar -xf /sources/autoconf-2.69.tar.xz -C /sources

cd /sources/autoconf-2.69

./configure --prefix=/usr

make

make install

cd /sources

rm -Rf autoconf-2.69

cd /scripts