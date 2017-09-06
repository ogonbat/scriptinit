#!/usr/bin/env bash

tar -xf $LFS/sources/flex-2.6.4.tar.gz -C $LFS/sources

cd $LFS/sources/flex-2.6.4
sed -i "/math.h/a #include <malloc.h>" src/flexdef.h

HELP2MAN=/tools/bin/true \
./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.6.4

make

make DESTDIR=$LFS install
ln -sv flex $LFS/usr/bin/lex

cd $LFS/sources

rm -Rf flex-2.6.4

cd $LFS/scripts