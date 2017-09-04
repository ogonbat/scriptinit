#!/usr/bin/env bash

tar -xf /sources/grub-2.02.tar.xz -C /sources

cd /sources/grub-2.02

./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-efiemu       \
            --disable-werror

make

make install

cd /sources

rm -Rf grub-2.02

cd /scripts