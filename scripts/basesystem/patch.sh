#!/usr/bin/env bash

tar -xf /sources/patch-2.7.5.tar.xz -C /sources

cd /sources/patch-2.7.5

./configure --prefix=/usr

make
make install

cd /sources

rm -Rf patch-2.7.5

cd /scripts