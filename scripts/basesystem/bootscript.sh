#!/usr/bin/env bash

tar -xf /sources/lfs-bootscripts-20170626.tar.bz2 -C /sources

cd /sources/lfs-bootscripts-20170626

make install

cd /sources

rm -Rf lfs-bootscripts-20170626

cd /scripts