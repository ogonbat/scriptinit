#!/usr/bin/env bash

set -e
trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG
trap 'echo FAILED COMMAND: $previous_command' EXIT

mkdir $PWD/build

export MRX=$PWD
export LFS=$PWD/build

mkdir -v $LFS/sources

chmod -v a+wt $LFS/sources

wget --input-file=wget-list --continue --directory-prefix=$LFS/sources

mkdir -v $LFS/tools

ln -sv $LFS/tools /

export LC_ALL=POSIX
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export PATH=/tools/bin:/bin:/usr/bin

export MAKEFLAGS='-j 4'


echo "Start Toolchain"

echo "Install Binutils"
source ./scripts/toolchain/binutils.sh 2>&1
echo "Install GCC"
source ./scripts/toolchain/gcc.sh 2>&1
echo "Install Linux"
source ./scripts/toolchain/linux.sh 2>&1
echo "Install GLibc"
source ./scripts/toolchain/glibc.sh 2>&1
echo "Install Libstdc"
source ./scripts/toolchain/libstdc.sh 2>&1
echo "Install Binutils Step 2"
source ./scripts/toolchain/binutils.2.sh 2>&1
echo "Install GCC Step 2"
source ./scripts/toolchain/gcc.2.sh 2>&1
echo "Install TCL"
source ./scripts/toolchain/tcl.sh 2>&1
echo "Install Expect"
source ./scripts/toolchain/expect.sh 2>&1
echo "Install DejaGNU"
source ./scripts/toolchain/dejagnu.sh 2>&1
echo "Install Check"
source ./scripts/toolchain/check.sh 2>&1
echo "Install Ncurses"
source ./scripts/toolchain/ncurses.sh 2>&1
echo "Install Bash"
source ./scripts/toolchain/bash.sh 2>&1
echo "Install Bison"
source ./scripts/toolchain/bison.sh 2>&1
echo "Install Bzip2"
source ./scripts/toolchain/bzip.sh 2>&1
echo "Install Coreutils"
source ./scripts/toolchain/coreutils.sh 2>&1
echo "Install Diffutils"
source ./scripts/toolchain/diffutils.sh 2>&1
echo "Install File"
source ./scripts/toolchain/file.sh 2>&1
echo "Install Findutils"
source ./scripts/toolchain/findutils.sh 2>&1
echo "Install Gawk"
source ./scripts/toolchain/gawk.sh 2>&1
echo "Install Gettext"
source ./scripts/toolchain/gettext.sh 2>&1
echo "Install Grep"
source ./scripts/toolchain/grep.sh 2>&1
echo "Install Gzip"
source ./scripts/toolchain/gzip.sh 2>&1
echo "Install M4"
source ./scripts/toolchain/m4.sh 2>&1
echo "Install Make"
source ./scripts/toolchain/make.sh 2>&1
echo "Install Patch"
source ./scripts/toolchain/patch.sh 2>&1
echo "Install Perl"
source ./scripts/toolchain/perl.sh 2>&1
echo "Install Sed"
source ./scripts/toolchain/sed.sh 2>&1
echo "Install Tar"
source ./scripts/toolchain/tar.sh 2>&1
echo "Install Texinfo"
source ./scripts/toolchain/texinfo.sh 2>&1
echo "Install Util Linux"
source ./scripts/toolchain/utillinux.sh 2>&1
echo "Install XZ"
source ./scripts/toolchain/xz.sh 2>&1


trap - EXIT
echo "Stripping"

strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*
rm -rf /tools/{,share}/{info,man,doc}


echo "Prepare the BaseSystem"
mkdir -pv $LFS/{dev,proc,sys,run}
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

mount -v --bind /dev $LFS/dev

mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

echo "Enter in CHROOT"
echo "Command:"
echo "chroot \"$LFS\" /tools/bin/env -i HOME=/root TERM=\"$TERM\" PS1='\u:\w\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin /tools/bin/bash --login +h"

mkdir -v $LFS/scripts
cp -R scripts/basesystem/* build/scripts

echo "Complete"