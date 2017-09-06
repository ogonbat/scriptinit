#!/usr/bin/env bash

tar -xf $LFS/sources/ncurses-6.0.tar.gz -C $LFS/sources

cd $LFS/sources/ncurses-6.0

sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --enable-pc-files       \
            --enable-widec

make

make DESTDIR=$LFS install

mv -v $LFS/usr/lib/libncursesw.so.6* $LFS/lib

ln -sfv ../../lib/$(readlink $LFS/usr/lib/libncursesw.so) $LFS/usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf                    $LFS/usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > $LFS/usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc        $LFS/usr/lib/pkgconfig/${lib}.pc
done

rm -vf                     $LFS/usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libcursesw.so
ln -sfv libncurses.so      $LFS/usr/lib/libcurses.so

mkdir -v       $LFS/usr/share/doc/ncurses-6.0
cp -v -R doc/* $LFS/usr/share/doc/ncurses-6.0


cd $LFS/sources

rm -Rf ncurses-6.0

cd $LFS/scripts