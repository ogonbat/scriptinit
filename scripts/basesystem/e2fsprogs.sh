#!/usr/bin/env bash

tar -xf $LFS/sources/e2fsprogs-1.43.5.tar.gz -C $LFS/sources

cd $LFS/sources/e2fsprogs-1.43.5

mkdir -v build
cd build

LIBS=-L/tools/lib                    \
CFLAGS=-I/tools/include              \
PKG_CONFIG_PATH=/tools/lib/pkgconfig \
../configure --prefix=/usr           \
             --bindir=/bin           \
             --with-root-prefix=""   \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck


make
ln -sfv /tools/lib/lib{blk,uu}id.so.1 lib


make DESTDIR=$LFS install
make DESTDIR=$LFS install-libs
chmod -v u+w $LFS/usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

gunzip -v $LFS/usr/share/info/libext2fs.info.gz
install-info --dir-file=$LFS/usr/share/info/dir $LFS/usr/share/info/libext2fs.info
makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644 doc/com_err.info $LFS/usr/share/info
install-info --dir-file=$LFS/usr/share/info/dir $LFS/usr/share/info/com_err.info

cd $LFS/sources

rm -Rf e2fsprogs-1.43.5

cd $LFS/scripts