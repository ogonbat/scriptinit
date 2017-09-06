#!/usr/bin/env bash

tar -xf $LFS/sources/man-db-2.7.6.1.tar.xz -C $LFS/sources

cd $LFS/sources/man-db-2.7.6.1

./configure --prefix=/usr                        \
            --docdir=/usr/share/doc/man-db-2.7.6.1 \
            --sysconfdir=/etc                    \
            --disable-setuid                     \
            --enable-cache-owner=bin             \
            --with-browser=/usr/bin/lynx         \
            --with-vgrind=/usr/bin/vgrind        \
            --with-grap=/usr/bin/grap            \
            --with-systemdtmpfilesdir=

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf man-db-2.7.6.1

cd $LFS/scripts