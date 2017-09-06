#!/usr/bin/env bash

tar -xf $LFS/sources/sysvinit-2.88dsf.tar.bz2 -C $LFS/sources

cd $LFS/sources/sysvinit-2.88dsf

patch -Np1 -i ../sysvinit-2.88dsf-consolidated-1.patch

make -C src
make ROOT=$LFS -C src install

cd $LFS/sources

rm -Rf sysvinit-2.88dsf

cd $LFS/scripts