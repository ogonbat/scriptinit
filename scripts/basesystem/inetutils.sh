#!/usr/bin/env bash

tar -xf /sources/inetutils-1.9.4.tar.xz -C /sources

cd /sources/inetutils-1.9.4

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

make install
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin

cd /sources

rm -Rf inetutils-1.9.4

cd /scripts