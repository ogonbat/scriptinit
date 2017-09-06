#!/usr/bin/env bash

tar -xf $LFS/sources/bc-1.07.1.tar.gz -C $LFS/sources

cd $LFS/sources/bc-1.07.1

cat > bc/fix-libmath_h << "EOF"
#! /bin/bash
sed -e '1   s/^/{"/' \
    -e     's/$/",/' \
    -e '2,$ s/^/"/'  \
    -e   '$ d'       \
    -i libmath.h

sed -e '$ s/$/0}/' \
    -i libmath.h
EOF

ln -sv /tools/lib/libncursesw.so.6 $LFS/usr/lib/libncursesw.so.6
ln -sfv libncurses.so.6 $LFS/usr/lib/libncurses.so

sed -i -e '/flex/s/as_fn_error/: ;; # &/' configure

./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf bc-1.07.1

cd $LFS/scripts