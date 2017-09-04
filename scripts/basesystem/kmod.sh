#!/usr/bin/env bash

tar -xf /sources/kmod-24.tar.xz -C /sources

cd /sources/kmod-24

./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib

make
make install

for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sfv ../bin/kmod /sbin/$target
done

ln -sfv kmod /bin/lsmod

cd /sources

rm -Rf kmod-24

cd /scripts