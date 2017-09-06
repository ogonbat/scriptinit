#!/usr/bin/env bash


apt-get update
apt-get install -y build-essential bison gawk linux-headers-$(uname -r) texinfo libgmp-dev libmpfr-dev libmpc-dev wget python3-pip libisl-dev libisl15 module-assistant

ln -fsv /bin/bash /bin/sh