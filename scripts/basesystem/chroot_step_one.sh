#!/tools/bin/env bash

set -e
trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG
trap 'echo FAILED COMMAND: $previous_command' EXIT

echo "Create Directories"

mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp
mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -v  /usr/libexec
mkdir -pv /usr/{,local/}share/man/man{1..8}

case $(uname -m) in
 x86_64) mkdir -v /lib64 ;;
esac

mkdir -v /var/{log,mail,spool}
ln -sv /run /var/run
ln -sv /run/lock /var/lock
mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local}

ln -sv /tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty} /bin
ln -sv /tools/bin/{install,perl} /usr/bin
ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
ln -sv /tools/lib/libstdc++.{a,so{,.6}} /usr/lib
sed 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la
ln -sv bash /bin/sh


echo "Install Linux"
source linux.sh

echo "Install Man Pages"
source manpages.sh

echo "Install GlibC"
source glibc.sh

mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(uname -m)-pc-linux-gnu/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(uname -m)-pc-linux-gnu/bin/ld

gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs

echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'


rm -v dummy.c a.out dummy.log

echo "Install Zlib"
source zlib.sh

echo "Install File"
source file.sh

echo "Install Readline"
source readline.sh

echo "Install M4"
source m4.sh

echo "Install BC"
source bc.sh

echo "Install Binutils"
source binutils.sh

echo "Install GMP"
source gmp.sh

echo "Install MPFR"
source mpfr.sh

echo "Install MPC"
source mpc.sh

echo "Install GCC"
source gcc.sh

echo "Install BZip2"
source bzip.sh

echo "Install PkgConfig"
source pkgconfig.sh

echo "Install Ncurses"
source ncurses.sh

echo "Install Attr"
source attr.sh

echo "Install Acl"
source acl.sh

echo "Install Libcap"
source libcap.sh

echo "Install Sed"
source sed.sh

echo "Install Shadow"
source shadow.sh

echo "Install PsMisc"
source psmisc.sh

echo "Install Iana"
source iana.sh

echo "Install Bison"
source bison.sh

echo "Install Flex"
source flex.sh

echo "Install Grep"
source grep.sh

echo "Install Bash"
source bash.sh

trap - EXIT
echo "Now is time to login with the new bash installed"
echo "Command:"
echo "exec /bin/bash --login +h"
echo "After that start the chroot step two"

