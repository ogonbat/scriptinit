#!/usr/bin/env bash

tar -xf $LFS/sources/expat-2.2.3.tar.bz2 -C $LFS/sources

cd $LFS/sources/expat-2.2.3

sed -i 's|usr/bin/env |bin/|' run.sh.in

./configure --prefix=/usr --disable-static

make

make DESTDIR=$LFS install
install -v -dm755 $LFS/usr/share/doc/expat-2.2.3
install -v -m644 doc/*.{html,png,css} $LFS/usr/share/doc/expat-2.2.3

cd $LFS/sources

rm -Rf expat-2.2.3

cd $LFS/scripts