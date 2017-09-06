#!/usr/bin/env bash

tar -xf $LFS/sources/grub-2.02.tar.xz -C $LFS/sources

cd $LFS/sources/grub-2.02

./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-efiemu       \
            --disable-werror

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf grub-2.02

cd $LFS/scripts