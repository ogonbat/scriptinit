#!/usr/bin/env bash

tar -xf /sources/iana-etc-2.30.tar.bz2 -C /sources

cd /sources/iana-etc-2.30

make

make install

cd /sources

rm -Rf iana-etc-2.30

cd /scripts