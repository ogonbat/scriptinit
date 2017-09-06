#!/usr/bin/env bash

tar -xf $LFS/sources/sysklogd-1.5.1.tar.gz -C $LFS/sources

cd $LFS/sources/sysklogd-1.5.1

sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
sed -i 's/union wait/int/' syslogd.c
./configure --prefix=/usr

make
make prefix=$LFS BINDIR=$LFS/sbin install

cat > $LFS/etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF

cd $LFS/sources

rm -Rf sysklogd-1.5.1

cd $LFS/scripts