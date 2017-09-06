#!/usr/bin/env bash

tar -xf $LFS/sources/attr-2.4.47.src.tar.gz -C $LFS/sources

cd $LFS/sources/attr-2.4.47

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
sed -i -e "/SUBDIRS/s|man[25]||g" man/Makefile
sed -i 's:{(:\\{(:' test/run
./configure --prefix=/usr \
            --bindir=/bin \
            --disable-static

make

make prefix=$LFS/usr install install-dev install-lib
chmod -v 755 $LFS/usr/lib/libattr.so
mv -v $LFS/usr/lib/libattr.so.* $LFS/lib
ln -sfv ../../lib/$(readlink $LFS/usr/lib/libattr.so) $LFS/usr/lib/libattr.so

cd $LFS/sources

rm -Rf attr-2.4.47

cd $LFS/scripts