#!/tools/bin/env bash

set -e
trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG
trap 'echo FAILED COMMAND: $previous_command' EXIT

echo "Install Libtool"
source libtool.sh

echo "Install GDBM"
source gdbm.sh

echo "Install Gperf"
source gperf.sh

echo "Install Expat"
source expat.sh

echo "Install Inetutils"
source inetutils.sh

echo "Install Perl"
source perl.sh

echo "Install XML::Parser"
source xmlperl.sh

echo "Install IntlTool"
source intltool.sh

echo "Install Autoconf"
source autoconf.sh

echo "Install Automake"
source automake.sh

echo "Install Xz"
source xz.sh

echo "Install KMod"
source kmod.sh

echo "Install Gettext"
source gettext.sh

echo "Install ProcPSNG"
source procpsng.sh

echo "Install E2fsProgs"
source e2fsprogs.sh

echo "Install Ncurses"
source ncurses.sh

echo "Install Coreutils"
source coreutils.sh

echo "Install Diffutils"
source diffutils.sh

echo "Install Gawk"
source gawk.sh

echo "Install Findutils"
source findutils.sh

echo "Install Groff"
source groff.sh

echo "Install Grub"
source grub.sh

echo "Install Less"
source less.sh

echo "Install Gzip"
source gzip.sh

echo "Install IPRoute2"
source iproute.sh

echo "Install Kbd"
source kbd.sh

echo "Install LibPipeline"
source libpipeline.sh

echo "Install Make"
source make.sh

echo "Install Patch"
source patch.sh

echo "Install Sysklogd"
source sysklogd.sh

echo "Install Sysvinit"
source sysvinit.sh

echo "Install Eudev"
source eudev.sh

echo "Install Util Linux"
source utillinux.sh

echo "Install man DB"
source man-db.sh

echo "Install Tar"
source tar.sh

echo "Install TexInfo"
source texinfo.sh

echo "Install Vim"
source vim.sh


echo "Stripping"
save_lib="ld-2.26.so libc-2.26.so libpthread-2.26.so libthread_db-1.0.so"

cd /lib

for LIB in $save_lib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done

save_usrlib="libquadmath.so.0.0.0 libstdc++.so.6.0.24
             libmpx.so.2.0.1 libmpxwrappers.so.2.0.1 libitm.so.1.0.0
             libcilkrts.so.5.0.0 libatomic.so.1.2.0"

cd /usr/lib

for LIB in $save_usrlib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done

unset LIB save_lib save_usrlib

/tools/bin/find /usr/lib -type f -name \*.a \
   -exec /tools/bin/strip --strip-debug {} ';'

/tools/bin/find /lib /usr/lib -type f \( -name \*.so* -a ! -name \*dbg \) \
   -exec /tools/bin/strip --strip-unneeded {} ';'

/tools/bin/find /{bin,sbin} /usr/{bin,sbin,libexec} -type f \
    -exec /tools/bin/strip --strip-all {} ';'

rm -rf /tmp/*


trap - EXIT
echo "Now is time to logout and login in chroot with that command"
echo "Command:"
echo "chroot \"$LFS\" /usr/bin/env -i HOME=/root TERM=\"$TERM\" PS1='\u:\w\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login"
echo "and execute the last step"