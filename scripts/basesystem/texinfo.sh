#!/usr/bin/env bash

tar -xf /sources//texinfo-6.4.tar.xz -C /sources

cd /sources/texinfo-6.4

./configure --prefix=/usr --disable-static


make

make install
make TEXMF=/usr/share/texmf install-tex
pushd /usr/share/info
rm -v dir
for f in *
  do install-info $f dir 2>/dev/null
done
popd

cd /sources

rm -Rf texinfo-6.4

cd /scripts