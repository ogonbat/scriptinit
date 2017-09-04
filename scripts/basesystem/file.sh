#!/usr/bin/env bash

tar -xf /sources/file-5.31.tar.gz -C /sources

cd /sources/file-5.31

./configure --prefix=/usr

make

make install

cd /sources

rm -Rf file-5.31

cd /scripts