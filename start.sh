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
source ./scripts/toolchain/binutils

echo "Install GCC"
source ./scripts/toolchain/gcc

echo "Install Linux"
source ./scripts/toolchain/gcc


