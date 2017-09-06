#!/usr/bin/env bash

tar -xf $LFS/sources/coreutils-8.27.tar.xz -C $LFS/sources

cd $LFS/sources/coreutils-8.27

patch -Np1 -i ../coreutils-8.27-i18n-1.patch
sed -i '/test.lock/s/^/#/' gnulib-tests/gnulib.mk

FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime

FORCE_UNSAFE_CONFIGURE=1 make
chown -Rv nobody .
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} $LFS/bin
mv -v $LFS/usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} $LFS/bin
mv -v $LFS/usr/bin/{rmdir,stty,sync,true,uname} $LFS/bin
mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 $LFS/usr/share/man/man8/chroot.8
mv -v $LFS/usr/bin/{head,sleep,nice,test,[} $LFS/bin

cd $LFS/sources

rm -Rf coreutils-8.27

cd $LFS/scripts