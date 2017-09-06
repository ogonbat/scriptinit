#!/usr/bin/env bash

tar -xf $LFS/sources/XML-Parser-2.44.tar.gz -C $LFS/sources

cd $LFS/sources/XML-Parser-2.44

perl Makefile.PL

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -Rf XML-Parser-2.44

cd $LFS/scripts