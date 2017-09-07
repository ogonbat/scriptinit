#!/usr/bin/env bash

tar -xf $LFS/sources/gcc-7.2.0.tar.xz -C $LFS/sources

cd $LFS/sources/gcc-7.2.0

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac

rm -f $LFS/usr/lib/gcc

mkdir -v build
cd       build

SED=sed                               \
../configure --prefix=/usr            \
             --enable-languages=c,c++ \
             --disable-multilib       \
             --disable-bootstrap      \
             --with-system-zlib

make

make DESTDIR=$LFS install

ln -sv ../usr/bin/cpp $LFS/lib
ln -sv gcc $LFS/usr/bin/cc
install -v -dm755 $LFS/usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/7.2.0/liblto_plugin.so \
        $LFS/usr/lib/bfd-plugins/
mkdir -pv $LFS/usr/share/gdb/auto-load/usr/lib
mv -v $LFS/usr/lib/*gdb.py $LFS/usr/share/gdb/auto-load/usr/lib

cd $LFS/sources

rm -Rf gcc-7.2.0

cd $LFS/scripts
