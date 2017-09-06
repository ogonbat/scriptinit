#!/usr/bin/env bash

tar -xf $LFS/sources/inetutils-1.9.4.tar.xz -C $LFS/sources

cd $LFS/sources/inetutils-1.9.4

./configure --prefix=/usr        \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

make

make DESTDIR=$LFS install
mv -v $LFS/usr/bin/{hostname,ping,ping6,traceroute} $LFS/bin
mv -v $LFS/usr/bin/ifconfig $LFS/sbin

cd $LFS/sources

rm -Rf inetutils-1.9.4

cd $LFS/scripts