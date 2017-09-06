#!/usr/bin/env bash

tar -xf $LFS/sources/iana-etc-2.30.tar.bz2 -C $LFS/sources

cd $LFS/sources/iana-etc-2.30

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf iana-etc-2.30

cd $LFS/scripts