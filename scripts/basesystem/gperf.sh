#!/usr/bin/env bash

tar -xf /sources/gperf-3.1.tar.gz -C /sources

cd /sources/gperf-3.1

./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1

make

make install

cd /sources

rm -Rf gperf-3.1

cd /scripts