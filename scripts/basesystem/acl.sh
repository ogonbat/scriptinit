#!/usr/bin/env bash

tar -xf $LFS/sources/acl-2.2.52.src.tar.gz -C $LFS/sources

cd $LFS/sources/acl-2.2.52

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in

sed -i -e "/SUBDIRS/s|man[25]||g" man/Makefile
sed -i 's:{(:\\{(:' test/run
sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c


./configure --prefix=/usr    \
            --bindir=/bin    \
            --disable-static \
            --libexecdir=/usr/lib

make

make prefix=$LFS/usr install install-dev install-lib
chmod -v 755 $LFS/usr/lib/libacl.so

mv -v $LFS/usr/lib/libacl.so.* $LFS/lib
ln -sfv ../../lib/$(readlink $LFS/usr/lib/libacl.so) $LFS/usr/lib/libacl.so

cd $LFS/sources

rm -Rf acl-2.2.52

cd $LFS/scripts