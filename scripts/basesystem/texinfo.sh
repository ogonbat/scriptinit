#!/usr/bin/env bash

tar -xf $LFS/sources//texinfo-6.4.tar.xz -C $LFS/sources

cd $LFS/sources/texinfo-6.4

./configure --prefix=/usr --disable-static


make

make DESTDIR=$LFS install
make DESTDIR=$LFS TEXMF=/usr/share/texmf install-tex
pushd $LFS/usr/share/info
rm -v dir
for f in *
  do install-info $f dir 2>/dev/null
done
popd

cd $LFS/sources

rm -Rf texinfo-6.4

cd $LFS/scripts