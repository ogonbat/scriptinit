#!/usr/bin/env bash

tar -xf /sources/bash-4.4.tar.gz -C /sources

cd /sources/bash-4.4

patch -Np1 -i ../bash-4.4-upstream_fixes-1.patch

./configure --prefix=/usr                       \
            --docdir=/usr/share/doc/bash-4.4 \
            --without-bash-malloc               \
            --with-installed-readline

make

chown -Rv nobody .

make install

mv -vf /usr/bin/bash /bin

cd /sources

rm -Rf bash-4.4

cd /scripts