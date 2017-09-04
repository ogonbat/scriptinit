#!/usr/bin/env bash

tar -xf /sources/pkg-config-0.29.2.tar.gz -C /sources

cd /sources/pkg-config-0.29.2

./configure --prefix=/usr              \
            --with-internal-glib       \
            --disable-host-tool        \
            --docdir=/usr/share/doc/pkg-config-0.29.2

make
make install

cd /sources

rm -Rf pkg-config-0.29.2

cd /scripts