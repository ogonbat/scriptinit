#!/usr/bin/env bash

tar -xf $LFS/sources/gettext-0.19.8.1.tar.xz -C $LFS/sources

cd $LFS/sources/gettext-0.19.8.1

sed -i '/^TESTS =/d' gettext-runtime/tests/Makefile.in &&
sed -i 's/test-lock..EXEEXT.//' gettext-tools/gnulib-tests/Makefile.in

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.19.8.1

make
make DESTDIR=$LFS install

chmod -v 0755 $LFS/usr/lib/preloadable_libintl.so

cd $LFS/sources

rm -Rf gettext-0.19.8.1

cd $LFS/scripts