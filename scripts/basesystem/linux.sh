#!/usr/bin/env bash

tar -xf /sources/linux-4.12.7.tar.xz -C /sources

cd /sources/linux-4.12.7

make mrproper

make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include

cd /sources

rm -Rf linux-4.12.7

cd /scripts