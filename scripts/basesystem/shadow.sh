#!/usr/bin/env bash

tar -xf $LFS/sources/shadow-4.5.tar.xz -C $LFS/sources

cd $LFS/sources/shadow-4.5

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs

sed -i 's/1000/999/' etc/useradd

./configure --sysconfdir=/etc --with-group-name-max-length=32

make

make DESTDIR=$LFS install
mv -v $LFS/usr/bin/passwd $LFS/bin
#pwconv
#grpconv
#passwd root

cd $LFS/sources

rm -Rf shadow-4.5

cd $LFS/scripts