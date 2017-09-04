#!/tools/bin/env bash

set -e
trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG
trap 'echo FAILED COMMAND: $previous_command' EXIT

rm -f /usr/lib/lib{bfd,opcodes}.a
rm -f /usr/lib/libbz2.a
rm -f /usr/lib/lib{com_err,e2p,ext2fs,ss}.a
rm -f /usr/lib/libltdl.a
rm -f /usr/lib/libfl.a
rm -f /usr/lib/libfl_pic.a
rm -f /usr/lib/libz.a


echo "Install Bootscript"
source bootscript.sh

trap - EXIT