#!/usr/bin/env bash

tar -xf /sources/intltool-0.51.0.tar.gz -C /sources

cd /sources/intltool-0.51.0
sed -i 's:\\\${:\\\$\\{:' intltool-update.in

./configure --prefix=/usr

make

make install
nstall -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO
cd /sources

rm -Rf intltool-0.51.0

cd /scripts