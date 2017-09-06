#!/usr/bin/env bash

tar -xf $LFS/sources/util-linux-2.30.1.tar.xz -C $LFS/sources

cd $LFS/sources/util-linux-2.30.1
mkdir -pv $LFS/var/lib/hwclock

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime   \
            --docdir=/usr/share/doc/util-linux-2.30.1 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            --without-systemd    \
            --without-systemdsystemunitdir

make
chown -Rv nobody .

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf util-linux-2.30.1

cd $LFS/scripts