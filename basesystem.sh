#!/usr/bin/env bash

#set -e
#trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG
#trap 'echo FAILED COMMAND: $previous_command' EXIT

mkdir $PWD/build

export MRX=$PWD
export LFS=$PWD/build

mkdir -v $LFS/sources

chmod -v a+wt $LFS/sources

wget --input-file=wget-list --continue --directory-prefix=$LFS/sources

mkdir -v $LFS/tools

ln -sv $LFS/tools /

export LC_ALL=POSIX
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export PATH=/tools/bin:/bin:/usr/bin

export MAKEFLAGS='-j 4'


echo "Start Toolchain"

echo "Install Binutils"
source ./scripts/toolchain/binutils.sh 
echo "Install GCC"
source ./scripts/toolchain/gcc.sh 
echo "Install Linux"
source ./scripts/toolchain/linux.sh 
echo "Install GLibc"
source ./scripts/toolchain/glibc.sh 
echo "Install Libstdc"
source ./scripts/toolchain/libstdc.sh 
echo "Install Binutils Step 2"
source ./scripts/toolchain/binutils.2.sh 
echo "Install GCC Step 2"
source ./scripts/toolchain/gcc.2.sh 
echo "Install TCL"
source ./scripts/toolchain/tcl.sh 
echo "Install Expect"
source ./scripts/toolchain/expect.sh 
echo "Install DejaGNU"
source ./scripts/toolchain/dejagnu.sh 
echo "Install Check"
source ./scripts/toolchain/check.sh 
echo "Install Ncurses"
source ./scripts/toolchain/ncurses.sh 
echo "Install Bash"
source ./scripts/toolchain/bash.sh 
echo "Install Bison"
source ./scripts/toolchain/bison.sh 
echo "Install Bzip2"
source ./scripts/toolchain/bzip.sh 
echo "Install Coreutils"
source ./scripts/toolchain/coreutils.sh 
echo "Install Diffutils"
source ./scripts/toolchain/diffutils.sh 
echo "Install File"
source ./scripts/toolchain/file.sh 
echo "Install Findutils"
source ./scripts/toolchain/findutils.sh 
echo "Install Gawk"
source ./scripts/toolchain/gawk.sh 
echo "Install Gettext"
source ./scripts/toolchain/gettext.sh 
echo "Install Grep"
source ./scripts/toolchain/grep.sh 
echo "Install Gzip"
source ./scripts/toolchain/gzip.sh 
echo "Install M4"
source ./scripts/toolchain/m4.sh 
echo "Install Make"
source ./scripts/toolchain/make.sh 
echo "Install Patch"
source ./scripts/toolchain/patch.sh 
echo "Install Perl"
source ./scripts/toolchain/perl.sh 
echo "Install Sed"
source ./scripts/toolchain/sed.sh 
echo "Install Tar"
source ./scripts/toolchain/tar.sh 
echo "Install Texinfo"
source ./scripts/toolchain/texinfo.sh 
echo "Install Util Linux"
source ./scripts/toolchain/utillinux.sh 
echo "Install XZ"
source ./scripts/toolchain/xz.sh 


#trap - EXIT
echo "Stripping"

strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*
rm -rf /tools/{,share}/{info,man,doc}


#chroot env
echo "Prepare the BaseSystem"
mkdir -pv $LFS/{dev,proc,sys,run}
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

mount -v --bind /dev $LFS/dev

mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

mkdir -v $LFS/scripts
cp -R scripts/basesystem/* build/scripts

echo "Create CHROOT Directories"

mkdir -pv $LFS/{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv $LFS/{media/{floppy,cdrom},sbin,srv,var}
install -dv -m 0750 $LFS/root
install -dv -m 1777 $LFS/tmp $LFS/var/tmp
mkdir -pv $LFS/usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv $LFS/usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -v  $LFS/usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -v  $LFS/usr/libexec
mkdir -pv $LFS/usr/{,local/}share/man/man{1..8}

case $(uname -m) in
 x86_64) mkdir -v $LFS/lib64 ;;
esac

mkdir -v $LFS/var/{log,mail,spool}
ln -sv $LFS/run $LFS/var/run
ln -sv $LFS/run/lock $LFS/var/lock
mkdir -pv $LFS/var/{opt,cache,lib/{color,misc,locate},local}

ln -sv /tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty} $LFS/bin
ln -sv /tools/bin/{install,perl} $LFS/usr/bin
ln -sv /tools/lib/libgcc_s.so{,.1} $LFS/usr/lib
ln -sv /tools/lib/libstdc++.{a,so{,.6}} $LFS/usr/lib
sed 's/tools/usr/' /tools/lib/libstdc++.la > $LFS/usr/lib/libstdc++.la
#ln -sv bash /bin/sh

ln -sv $LFS/proc/self/mounts $LFS/etc/mtab

cat > $LFS/etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF

cat > $LFS/etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
systemd-journal:x:23:
input:x:24:
mail:x:34:
nogroup:x:99:
users:x:999:
EOF

cd $LFS/scripts

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

/tools/bin/gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs


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

echo "Stripping CHROOT"
save_lib="ld-2.26.so libc-2.26.so libpthread-2.26.so libthread_db-1.0.so"

cd $LFS/lib

for LIB in $save_lib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done

save_usrlib="libquadmath.so.0.0.0 libstdc++.so.6.0.24
             libmpx.so.2.0.1 libmpxwrappers.so.2.0.1 libitm.so.1.0.0
             libcilkrts.so.5.0.0 libatomic.so.1.2.0"

cd $LFS/usr/lib

for LIB in $save_usrlib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done

unset LIB save_lib save_usrlib

rm -rf /tmp/*


rm -f $LFS/usr/lib/lib{bfd,opcodes}.a
rm -f $LFS/usr/lib/libbz2.a
rm -f $LFS/usr/lib/lib{com_err,e2p,ext2fs,ss}.a
rm -f $LFS/usr/lib/libltdl.a
rm -f $LFS/usr/lib/libfl.a
rm -f $LFS/usr/lib/libfl_pic.a
rm -f $LFS/usr/lib/libz.a

cd $LFS/scripts
echo "Install Bootscript"
source bootscript.sh

bash $LFS/lib/udev/init-net-rules.sh

cat > $LFS/etc/resolv.conf << EOF
# Begin /etc/resolv.conf

# (*) Use Google's Public IPv4 DNS
nameserver 8.8.8.8
nameserver 8.8.4.4

# End /etc/resolv.conf
EOF

cat > $LFS/etc/hosts << EOF
# Begin /etc/hosts

# (*) Only create entries for localhost
127.0.0.1 localhost
::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters

# End /etc/hosts
EOF

cat > $LFS/etc/inittab << EOF
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF

cat > $LFS/etc/sysconfig/rc.site << "EOF"
# rc.site
# Optional parameters for boot scripts.

# Distro Information
# These values, if specified here, override the defaults
#DISTRO="Linux From Scratch" # The distro name
#DISTRO_CONTACT="lfs-dev@linuxfromscratch.org" # Bug report address
#DISTRO_MINI="LFS" # Short name used in filenames for distro config

# Define custom colors used in messages printed to the screen

# Please consult `man console_codes` for more information
# under the "ECMA-48 Set Graphics Rendition" section
#
# Warning: when switching from a 8bit to a 9bit font,
# the linux console will reinterpret the bold (1;) to
# the top 256 glyphs of the 9bit font.  This does
# not affect framebuffer consoles

# These values, if specified here, override the defaults
#BRACKET="\\033[1;34m" # Blue
#FAILURE="\\033[1;31m" # Red
#INFO="\\033[1;36m"    # Cyan
#NORMAL="\\033[0;39m"  # Grey
#SUCCESS="\\033[1;32m" # Green
#WARNING="\\033[1;33m" # Yellow

# Use a colored prefix
# These values, if specified here, override the defaults
#BMPREFIX="     "
#SUCCESS_PREFIX="${SUCCESS}  *  ${NORMAL}"
#FAILURE_PREFIX="${FAILURE}*****${NORMAL}"
#WARNING_PREFIX="${WARNING} *** ${NORMAL}"

# Manually seet the right edge of message output (characters)
# Useful when resetting console font during boot to override
# automatic screen width detection
#COLUMNS=120

# Interactive startup
#IPROMPT="yes" # Whether to display the interactive boot prompt
#itime="3"    # The amount of time (in seconds) to display the prompt

# The total length of the distro welcome string, without escape codes
#wlen=$(echo "Welcome to ${DISTRO}" | wc -c )
#welcome_message="Welcome to ${INFO}${DISTRO}${NORMAL}"

# The total length of the interactive string, without escape codes
#ilen=$(echo "Press 'I' to enter interactive startup" | wc -c )
#i_message="Press '${FAILURE}I${NORMAL}' to enter interactive startup"

# Set scripts to skip the file system check on reboot
#FASTBOOT=yes

# Skip reading from the console
#HEADLESS=yes

# Write out fsck progress if yes
#VERBOSE_FSCK=no

# Speed up boot without waiting for settle in udev
#OMIT_UDEV_SETTLE=y

# Speed up boot without waiting for settle in udev_retry
#OMIT_UDEV_RETRY_SETTLE=yes

# Skip cleaning /tmp if yes
#SKIPTMPCLEAN=no

# For setclock
UTC=1
#CLOCKPARAMS=

# For consolelog (Note that the default, 7=debug, is noisy)
LOGLEVEL=1

# For network
HOSTNAME=localhost

# Delay between TERM and KILL signals at shutdown
#KILLDELAY=3

# Optional sysklogd parameters
#SYSKLOGD_PARMS="-m 0"

# Console parameters
UNICODE=1
KEYMAP="us-acentos"
KEYMAP_CORRECTIONS="euro2"
FONT="lat0-16 -m 8859-15"
#LEGACY_CHARSET=

EOF

mkdir -pv $LFS/etc/profile.d

cat > $LFS/etc/profile.d/i18n.sh << EOF
# Set up i18n variables
export LANG="en_US.UTF-8"
EOF

cat > $LFS/etc/profile << EOF
# Minimal profile, which loads configuration from /etc/profile.d
for script in /etc/profile.d/*.sh ; do
  if [ -r ${script} ] ; then
    . ${script}
  fi
done
EOF

cat > $LFS/etc/inputrc << EOF
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

cat > $LFS/etc/shells << EOF
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF

cat > $LFS/etc/fstab << EOF
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

rootfs         /            auto     defaults            0     0

#/dev/<xxx>    /            <fff>    defaults            1     1
#/dev/<yyy>    swap         swap     pri=1               0     0

proc           /proc        proc     nosuid,noexec,nodev 0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs          /run         tmpfs    defaults            0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0

# End /etc/fstab
EOF

echo 0.0.1 > $LFS/etc/mrx-release

cat > $LFS/etc/lsb-release << "EOF"
DISTRIB_ID="Minerox"
DISTRIB_RELEASE="0.0.1"
DISTRIB_CODENAME="Andrea Mucci aKa cingusoft"
DISTRIB_DESCRIPTION="Minerox OS for Miners"
EOF

umount -v $LFS/dev/pts
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys


echo "Complete"