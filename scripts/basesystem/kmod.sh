#!/usr/bin/env bash

tar -xf $LFS/sources/kmod-24.tar.xz -C $LFS/sources

cd $LFS/sources/kmod-24

./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib

make
make DESTDIR=$LFS install

for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sfv ../bin/kmod $LFS/sbin/$target
done

ln -sfv kmod $LFS/bin/lsmod

cd $LFS/sources

rm -Rf kmod-24

cd $LFS/scripts