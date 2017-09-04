#!/usr/bin/env bash

tar -xf /sources/expat-2.2.3.tar.bz2 -C /sources

cd /sources/expat-2.2.3

sed -i 's|usr/bin/env |bin/|' run.sh.in

./configure --prefix=/usr --disable-static

make

make install
install -v -dm755 /usr/share/doc/expat-2.2.3
install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.2.3

cd /sources

rm -Rf expat-2.2.3

cd /scripts