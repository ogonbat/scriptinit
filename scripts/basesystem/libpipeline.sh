#!/usr/bin/env bash

tar -xf /sources/libpipeline-1.4.2.tar.gz -C /sources

cd /sources/libpipeline-1.4.2

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr

make

make install

cd /sources

rm -Rf libpipeline-1.4.2

cd /scripts