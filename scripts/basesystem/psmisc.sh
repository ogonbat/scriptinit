#!/usr/bin/env bash

tar -xf /sources/psmisc-23.1.tar.xz -C /sources

cd /sources/psmisc-23.1

./configure --prefix=/usr

make

make install

mv -v /usr/bin/fuser   /bin
mv -v /usr/bin/killall /bin

cd /sources

rm -Rf psmisc-23.1

cd /scripts