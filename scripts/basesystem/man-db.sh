#!/usr/bin/env bash

tar -xf /sources/man-db-2.7.6.1.tar.xz -C /sources

cd /sources/man-db-2.7.6.1

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

make install

cd /sources

rm -Rf man-db-2.7.6.1

cd /scripts