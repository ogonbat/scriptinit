#!/usr/bin/env bash

tar -xf /sources/m4-1.4.18.tar.xz -C /sources

cd /sources/m4-1.4.18

./configure --prefix=/usr

make

make install

cd /sources

rm -Rf m4-1.4.18

cd /scripts