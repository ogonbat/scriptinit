#!/usr/bin/env bash

tar -xf /sources/grep-3.1.tar.xz -C /sources

cd /sources/grep-3.1

./configure --prefix=/usr --bindir=/bin

make

make install

cd /sources

rm -Rf grep-3.1

cd /scripts