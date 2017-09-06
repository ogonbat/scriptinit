#!/usr/bin/env bash

tar -xf $LFS/sources/intltool-0.51.0.tar.gz -C $LFS/sources

cd $LFS/sources/intltool-0.51.0
sed -i 's:\\\${:\\\$\\{:' intltool-update.in

./configure --prefix=/usr

make

make DESTDIR=$LFS install
nstall -v -Dm644 doc/I18N-HOWTO $LFS/usr/share/doc/intltool-0.51.0/I18N-HOWTO

cd $LFS/sources

rm -Rf intltool-0.51.0

cd $LFS/scripts