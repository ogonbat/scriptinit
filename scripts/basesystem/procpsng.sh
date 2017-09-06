#!/usr/bin/env bash

tar -xf $LFS/sources/procps-ng-3.3.12.tar.xz -C $LFS/sources

cd $LFS/sources/procps-ng-3.3.12

./configure --prefix=/usr                            \
            --exec-prefix=                           \
            --libdir=/usr/lib                        \
            --docdir=/usr/share/doc/procps-ng-3.3.12 \
            --disable-static                         \
            --disable-kill


make

sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
sed -i '/set tty/d' testsuite/pkill.test/pkill.exp
rm testsuite/pgrep.test/pgrep.exp

make DESTDIR=$LFS install

mv -v $LFS/usr/lib/libprocps.so.* $LFS/lib
ln -sfv ../../lib/$(readlink $LFS/usr/lib/libprocps.so) $LFS/usr/lib/libprocps.so

cd $LFS/sources

rm -Rf procps-ng-3.3.12

cd $LFS/scripts