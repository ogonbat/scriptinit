#!/usr/bin/env bash

tar -xf $LFS/sources/glibc-2.26.tar.xz -C $LFS/sources

cd $LFS/sources/glibc-2.26

patch -Np1 -i ../glibc-2.26-fhs-1.patch
ln -sfv /tools/lib/gcc $LFS/usr/lib

case $(uname -m) in
    i?86)    GCC_INCDIR=$LFS/usr/lib/gcc/$(uname -m)-pc-linux-gnu/7.2.0/include
            ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) GCC_INCDIR=$LFS/usr/lib/gcc/x86_64-pc-linux-gnu/7.2.0/include
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

rm -f $LFS/usr/include/limits.h

mkdir -v build
cd       build


CC="gcc -isystem $GCC_INCDIR -isystem /usr/include" \
../configure --prefix=/usr                          \
             --disable-werror                       \
             --enable-kernel=3.2                    \
             --enable-stack-protector=strong        \
             libc_cv_slibdir=/lib
unset GCC_INCDIR

make

touch $LFS/etc/ld.so.conf
sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile

make install_root=$LFS install

cp -v ../nscd/nscd.conf $LFS/etc/nscd.conf
mkdir -pv $LFS/var/cache/nscd

make install_root=$LFS localedata/install-locales

cat > $LFS/etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

tar -xf ../../tzdata2017b.tar.gz

ZONEINFO=$LFS/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew systemv; do
    /tools/sbin/zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    /tools/sbin/zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    /tools/sbin/zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
/tools/sbin/zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

tzselect
cp -v $LFS/usr/share/zoneinfo/Canada/Eastern /etc/localtime

cat > $LFS/etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

cat >> $LFS/etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir -pv $LFS/etc/ld.so.conf.d

cd $LFS/sources

rm -Rf glibc-2.26

cd $LFS/scripts