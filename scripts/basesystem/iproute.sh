#!/usr/bin/env bash

tar -xf $LFS/sources/iproute2-4.12.0.tar.xz -C $LFS/sources

cd $LFS/sources/iproute2-4.12.0

sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile
rm -v doc/arpd.sgml
sed -i 's/m_ipt.o//' tc/Makefile


make

make DESTDIR=$LFS DOCDIR=/usr/share/doc/iproute2-4.12.0 install

cd $LFS/sources

rm -Rf iproute2-4.12.0

cd $LFS/scripts