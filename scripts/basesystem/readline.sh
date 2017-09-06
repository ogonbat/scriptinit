#!/usr/bin/env bash

tar -xf $LFS/sources/readline-7.0.tar.gz -C $LFS/sources

cd $LFS/sources/readline-7.0

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/readline-7.0

make SHLIB_LIBS="-L/tools/lib -lncursesw"
make DESTDIR=$LFS SHLIB_LIBS="-L/tools/lib -lncurses" install
mv -v $LFS/usr/lib/lib{readline,history}.so.* $LFS/lib
ln -sfv ../../lib/$(readlink $LFS/usr/lib/libreadline.so) $LFS/usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink $LFS/usr/lib/libhistory.so ) $LFS/usr/lib/libhistory.so
install -v -m644 doc/*.{ps,pdf,html,dvi} $LFS/usr/share/doc/readline-7.0

cd $LFS/sources

rm -Rf readline-7.0

cd $LFS/scripts