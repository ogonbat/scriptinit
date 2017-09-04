#!/usr/bin/env bash

tar -xf /sources/less-487.tar.gz -C /sources

cd /sources/less-487

./configure --prefix=/usr --sysconfdir=/etc

make

make install

cd /sources

rm -Rf less-487

cd /scripts