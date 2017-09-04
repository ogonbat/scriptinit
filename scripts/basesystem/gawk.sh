#!/usr/bin/env bash

tar -xf /sources/gawk-4.1.4.tar.xz -C /sources

cd /sources/gawk-4.1.4

./configure --prefix=/usr

make

make install
mkdir -v /usr/share/doc/gawk-4.1.4
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.1.4

cd /sources

rm -Rf gawk-4.1.4

cd /scripts