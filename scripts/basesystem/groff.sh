#!/usr/bin/env bash

tar -xf /sources/groff-1.22.3.tar.gz -C /sources

cd /sources/groff-1.22.3

PAGE=A4 ./configure --prefix=/usr

make -j1

make install

cd /sources

rm -Rf groff-1.22.3

cd /scripts