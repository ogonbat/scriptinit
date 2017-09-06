#!/usr/bin/env bash

tar -xf $LFS/sources/sed-4.4.tar.xz -C $LFS/sources

cd $LFS/sources/sed-4.4

sed -i 's/usr/tools/'                 build-aux/help2man
sed -i 's/testsuite.panic-tests.sh//' Makefile.in

./configure --prefix=/usr --bindir=/bin
make
make html

make DESTDIR=$LFS install
install -d -m755           $LFS/usr/share/doc/sed-4.4
install -m644 doc/sed.html $LFS/usr/share/doc/sed-4.4

cd $LFS/sources

rm -Rf sed-4.4

cd $LFS/scripts