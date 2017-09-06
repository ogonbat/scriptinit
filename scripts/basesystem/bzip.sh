#!/usr/bin/env bash

tar -xf $LFS/sources/bzip2-1.0.6.tar.gz -C $LFS/sources

cd $LFS/sources/bzip2-1.0.6

patch -Np1 -i ../bzip2-1.0.6-install_docs-1.patch

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -f Makefile-libbz2_so
make clean

make

make PREFIX=$LFS/usr install

cp -v bzip2-shared $LFS/bin/bzip2
cp -av libbz2.so* $LFS/lib
ln -sv ../../lib/libbz2.so.1.0 $LFS/usr/lib/libbz2.so
rm -v $LFS/usr/bin/{bunzip2,bzcat,bzip2}
ln -sv bzip2 $LFS/bin/bunzip2
ln -sv bzip2 $LFS/bin/bzcat


cd $LFS/sources

rm -Rf bzip2-1.0.6

cd $LFS/scripts