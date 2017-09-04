#!/usr/bin/env bash

tar -xf /sources/diffutils-3.6.tar.xz -C /sources

cd /sources/diffutils-3.6

./configure --prefix=/usr

make

make install

cd /sources

rm -Rf diffutils-3.6

cd /scripts