#!/usr/bin/env bash

tar -xf $LFS/sources/eudev-3.2.2.tar.gz -C $LFS/sources

cd $LFS/sources/eudev-3.2.2
sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl
sed -i '/keyboard_lookup_key/d' src/udev/udev-builtin-keyboard.c

cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF

./configure --prefix=/usr           \
            --bindir=/sbin          \
            --sbindir=/sbin         \
            --libdir=/usr/lib       \
            --sysconfdir=/etc       \
            --libexecdir=/lib       \
            --with-rootprefix=      \
            --with-rootlibdir=/lib  \
            --enable-manpages       \
            --disable-static        \
            --config-cache

LIBRARY_PATH=/tools/lib make
mkdir -pv $LFS/lib/udev/rules.d
mkdir -pv $LFS/etc/udev/rules.d

make DESTDIR=$LFS LD_LIBRARY_PATH=/tools/lib install
tar -xvf ../udev-lfs-20140408.tar.bz2
make DESTDIR=$LFS -f udev-lfs-20140408/Makefile.lfs install

LD_LIBRARY_PATH=/tools/lib udevadm hwdb --update
cd $LFS/sources

rm -Rf eudev-3.2.2

cd $LFS/scripts