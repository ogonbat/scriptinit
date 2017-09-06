#!/bin/env bash

tar -xf $LFS/sources/bash-4.4.tar.gz -C $LFS/sources

cd $LFS/sources/bash-4.4

patch -Np1 -i ../bash-4.4-upstream_fixes-1.patch

./configure --prefix=/usr                       \
            --docdir=/usr/share/doc/bash-4.4 \
            --without-bash-malloc               \
            --with-installed-readline

make

chown -Rv nobody .

make DESTDIR=$LFS install

mv -vf $LFS/usr/bin/bash $LFS/bin

cd $LFS/sources

rm -Rf bash-4.4

cd $LFS/scripts