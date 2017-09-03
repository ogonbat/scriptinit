#!/usr/bin/env bash

mkdir $PWD/build

export LFS=$PWD/build

mkdir -v $LFS/sources

chmod -v a+wt $LFS/sources

wget --input-file=wget-list --continue --directory-prefix=$LFS/sources

pushd $LFS/sources
md5sum -c md5sums
popd

mkdir -v $LFS/tools

ln -sv $LFS/tools /

export LC_ALL=POSIX
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export PATH=/tools/bin:/bin:/usr/bin

export MAKEFLAGS='-j 4'


echo "Start Toolchain"

echo "Install Binutils"
source ./scripts/toolchain/binutils.sh

echo "Install GCC"
source ./scripts/toolchain/gcc.sh

echo "Install Linux"
source ./scripts/toolchain/linux.sh

echo "Install GLibc"
source ./scripts/toolchain/glibc.sh

echo "Install Libstdc"
source ./scripts/toolchain/libstdc.sh

echo "Install Binutils Step 2"
source ./scripts/toolchain/binutils.2.sh

echo "Install GCC Step 2"
source ./scripts/toolchain/gcc.2.sh

echo "Install TCL"
source ./scripts/toolchain/tcl.sh

echo "Install Expect"
source ./scripts/toolchain/expect.sh

echo "Install DejaGNU"
source ./scripts/toolchain/dejagnu.sh

echo "Install Check"
source ./scripts/toolchain/check.sh

echo "Install Ncurses"
source ./scripts/toolchain/ncurses.sh

echo "Install Bash"
source ./scripts/toolchain/bash.sh

echo "Install Bison"
source ./scripts/toolchain/bison.sh