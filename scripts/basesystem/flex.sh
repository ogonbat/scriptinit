#!/usr/bin/env bash

tar -xf /sources/flex-2.6.4.tar.gz -C /sources

cd /sources/flex-2.6.4
sed -i "/math.h/a #include <malloc.h>" src/flexdef.h

HELP2MAN=/tools/bin/true \
./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.6.4

make

make install
ln -sv flex /usr/bin/lex

cd /sources

rm -Rf flex-2.6.4

cd /scripts