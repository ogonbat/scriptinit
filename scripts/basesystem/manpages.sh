#!/usr/bin/env bash

tar -xf /sources/man-pages-4.12.tar.xz -C /sources

cd /sources/man-pages-4.12

make install

cd /sources

rm -Rf man-pages-4.12

cd /scripts