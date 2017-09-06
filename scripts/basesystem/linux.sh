#!/usr/bin/env bash

tar -xf ${LFS}/sources/linux-4.12.7.tar.xz -C $LFS/sources

cd ${LFS}/sources/linux-4.12.7

make mrproper

make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* $LFS/usr/include

cd ${LFS}/sources

rm -Rf linux-4.12.7

cd ${LFS}/scripts