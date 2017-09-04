#!/usr/bin/env bash

tar -xf /sources/findutils-4.6.0.tar.gz -C /sources

cd /sources/findutils-4.6.0

sed -i 's/test-lock..EXEEXT.//' tests/Makefile.in

./configure --prefix=/usr --localstatedir=/var/lib/locate

make

make install
mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb

cd /sources

rm -Rf findutils-4.6.0

cd /scripts