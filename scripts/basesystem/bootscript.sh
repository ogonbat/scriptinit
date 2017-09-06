#!/usr/bin/env bash

tar -xf $LFS/sources/lfs-bootscripts-20170626.tar.bz2 -C $LFS/sources

cd $LFS/sources/lfs-bootscripts-20170626

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf lfs-bootscripts-20170626

cd $LFS/scripts