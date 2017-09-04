#!/usr/bin/env bash

tar -xf /sources/libcap-2.25.tar.xz -C /sources

cd /sources/libcap-2.25

sed -i '/install.*STALIBNAME/d' libcap/Makefile

make
make RAISE_SETFCAP=no lib=lib prefix=/usr install
chmod -v 755 /usr/lib/libcap.so

mv -v /usr/lib/libcap.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so

cd /sources

rm -Rf libcap-2.25

cd /scripts