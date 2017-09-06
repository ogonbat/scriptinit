#!/usr/bin/env bash

tar -xf $LFS/sources/man-pages-4.12.tar.xz -C $LFS/sources

cd $LFS/sources/man-pages-4.12

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf man-pages-4.12

cd $LFS/scripts