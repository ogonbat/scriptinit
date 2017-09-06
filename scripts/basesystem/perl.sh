#!/usr/bin/env bash

tar -xf $LFS/sources/perl-5.26.0.tar.xz -C $LFS/sources

cd $LFS/sources/perl-5.26.0
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
export BUILD_ZLIB=False
export BUILD_BZIP2=0

sh Configure -des -Dprefix=/usr                 \
                  -Dvendorprefix=/usr           \
                  -Dman1dir=/usr/share/man/man1 \
                  -Dman3dir=/usr/share/man/man3 \
                  -Dpager="/usr/bin/less -isR"  \
                  -Duseshrplib                  \
                  -Dusethreads

make DESTDIR=$LFS install
unset BUILD_ZLIB BUILD_BZIP2

cd $LFS/sources

rm -Rf perl-5.26.0

cd $LFS/scripts