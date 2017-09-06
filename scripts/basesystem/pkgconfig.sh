#!/usr/bin/env bash

tar -xf $LFS/sources/pkg-config-0.29.2.tar.gz -C $LFS/sources

cd $LFS/sources/pkg-config-0.29.2

./configure --prefix=/usr              \
            --with-internal-glib       \
            --disable-host-tool        \
            --docdir=/usr/share/doc/pkg-config-0.29.2

make
make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf pkg-config-0.29.2

cd $LFS/scripts