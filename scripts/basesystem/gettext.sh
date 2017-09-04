#!/usr/bin/env bash

tar -xf /sources/gettext-0.19.8.1.tar.xz -C /sources

cd /sources/gettext-0.19.8.1

sed -i '/^TESTS =/d' gettext-runtime/tests/Makefile.in &&
sed -i 's/test-lock..EXEEXT.//' gettext-tools/gnulib-tests/Makefile.in

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.19.8.1

make
make install

chmod -v 0755 /usr/lib/preloadable_libintl.so

cd /sources

rm -Rf gettext-0.19.8.1

cd /scripts