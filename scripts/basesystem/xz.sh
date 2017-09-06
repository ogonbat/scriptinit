#!/usr/bin/env bash

tar -xf $LFS/sources/xz-5.2.3.tar.xz -C $LFS/sources

cd $LFS/sources/xz-5.2.3

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.2.3

make
sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh
make DESTDIR=$LFS install
mv -v   $LFS/usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} $LFS/bin
mv -v $LFS/usr/lib/liblzma.so.* $LFS/lib
ln -svf ../../lib/$(readlink $LFS/usr/lib/liblzma.so) $LFS/usr/lib/liblzma.so

cd $LFS/sources

rm -Rf xz-5.2.3

cd $LFS/scripts