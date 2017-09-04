#!/usr/bin/env bash

tar -xf /sources/XML-Parser-2.44.tar.gz -C /sources

cd /sources/XML-Parser-2.44

perl Makefile.PL

make

make install

cd /sources

rm -Rf XML-Parser-2.44

cd /scripts