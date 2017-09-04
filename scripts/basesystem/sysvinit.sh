#!/usr/bin/env bash

tar -xf /sources/sysvinit-2.88dsf.tar.bz2 -C /sources

cd /sources/sysvinit-2.88dsf

patch -Np1 -i ../sysvinit-2.88dsf-consolidated-1.patch

make -C src
make -C src install

cd /sources

rm -Rf sysvinit-2.88dsf

cd /scripts