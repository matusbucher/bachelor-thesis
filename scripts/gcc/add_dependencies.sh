#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

GCC="/usr/libexec/gcc/x86_64-linux-gnu/13/cc1"
if [ ! -e "$GCC" ]; then
	echo "Dependency $GCC not found. Skipping..."
	NOT_FOUND=$((NOT_FOUND + 1))
	continue
fi

GCC_DEST="$ROOT_DIR$GCC"
mkdir -p "$(dirname "$GCC_DEST")"
cp "$GCC" "$GCC_DEST"
echo "Copied dependency $GCC."


LIB_DIR1="/usr/lib/x86_64-linux-gnu/"

declare -a LIBS1=(
	"libisl.so.23"
	"libmpc.so.3"
	"libmpfr.so.6"
	"libgmp.so.10"
	"libm.so.6"
	"Scrt1.o"
	"crti.o"
	"crtn.o"
	"libgcc_s.so.1"
	"libc.so"
	"libc_nonshared.a"
)

for LIB in ${LIBS1[@]}; do
	DEP="$LIB_DIR1$LIB"

	if [ ! -e "$DEP" ]; then
		echo "Dependency $DEP not found. Skipping..."
		NOT_FOUND=$((NOT_FOUND + 1))
		continue
	fi
	
	DEP_DEST="$ROOT_DIR$DEP"

	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
		if [ ! -d "$DEP_DEST" ]; then
			mkdir "$DEP_DEST"
		fi
		cp -rL "$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $DEP."
done


LIB_DIR2="/usr/lib/gcc/x86_64-linux-gnu/13/"

declare -a LIBS2=(
	"crtbeginS.o"
	"crtendS.o"
	"liblto_plugin.so"
	"libgcc.a"
	"libgcc_s.so"
	"include/stddef.h"
)

for LIB in ${LIBS2[@]}; do
	DEP="$LIB_DIR2$LIB"

	if [ ! -e "$DEP" ]; then
		echo "Dependency $DEP not found. Skipping..."
		NOT_FOUND=$((NOT_FOUND + 1))
		continue
	fi
	
	DEP_DEST="$ROOT_DIR$DEP"

	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
		if [ ! -d "$DEP_DEST" ]; then
			mkdir "$DEP_DEST"
		fi
		cp -rL "$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $DEP."
done


INCLUDE_DIR1="/usr/include/"

declare -a INCLUDES1=(
	"alloca.h"
	"stdlib.h"
	"unistd.h"
	"features.h"
	"features-time64.h"
	"stdc-predef.h"
	"stddef.h"
	"endian.h"
	"arpa/inet.h"
	"netinet/in.h"
	"asm-generic/socket.h"
	"linux/posix_types.h"
	"linux/stddef.h"
	"asm-generic/posix_types.h"
	"asm-generic/bitsperlong.h"
	"asm-generic/sockios.h"
)

for INCLUDE in ${INCLUDES1[@]}; do
	DEP="$INCLUDE_DIR1$INCLUDE"

	if [ ! -e "$DEP" ]; then
		echo "Dependency $DEP not found. Skipping..."
		NOT_FOUND=$((NOT_FOUND + 1))
		continue
	fi
	
	DEP_DEST="$ROOT_DIR$DEP"

	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
		if [ ! -d "$DEP_DEST" ]; then
			mkdir "$DEP_DEST"
		fi
		cp -rL "$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $DEP."
done


INCLUDE_DIR2="/usr/include/x86_64-linux-gnu/"

declare -a INCLUDES2=(
	"bits/libc-header-start.h"
	"bits/wordsize.h"
	"bits/timesize.h"
	"sys/cdefs.h"
	"bits/long-double.h"
	"gnu/stubs.h"
	"gnu/stubs-64.h"
	"bits/waitflags.h"
	"bits/waitstatus.h"
	"bits/floatn.h"
	"bits/floatn-common.h"
	"sys/types.h"
	"bits/types.h"
	"bits/typesizes.h"
	"bits/time64.h"
	"bits/types/clock_t.h"
	"bits/types/clockid_t.h"
	"bits/types/time_t.h"
	"bits/types/timer_t.h"
	"bits/stdint-intn.h"
	"bits/endian.h"
	"bits/endianness.h"
	"bits/byteswap.h"
	"bits/uintn-identity.h"
	"sys/select.h"
	"bits/select.h"
	"bits/types/sigset_t.h"
	"bits/types/__sigset_t.h"
	"bits/types/struct_timeval.h"
	"bits/types/struct_timespec.h"
	"bits/pthreadtypes.h"
	"bits/thread-shared-types.h"
	"bits/pthreadtypes-arch.h"
	"bits/atomic_wide_counter.h"
	"bits/struct_mutex.h"
	"bits/struct_rwlock.h"
	"bits/stdlib-float.h"
	"bits/posix_opt.h"
	"bits/environments.h"
	"bits/getopt_posix.h"
	"bits/getopt_core.h"
	"bits/unistd_ext.h"
	"bits/stdint-uintn.h"
	"bits/types/struct_iovec.h"
	"bits/socket.h"
	"bits/socket_type.h"
	"bits/sockaddr.h"
	"sys/socket.h"
	"asm/socket.h"
	"asm/posix_types.h"
	"asm/posix_types_64.h"
	"asm/bitsperlong.h"
	"asm/sockios.h"
	"bits/types/struct_osockaddr.h"
	"bits/in.h"
	"bits/confname.h"
)

for INCLUDE in ${INCLUDES2[@]}; do
	DEP="$INCLUDE_DIR2$INCLUDE"

	if [ ! -e "$DEP" ]; then
		echo "Dependency $DEP not found. Skipping..."
		NOT_FOUND=$((NOT_FOUND + 1))
		continue
	fi
	
	DEP_DEST="$ROOT_DIR$DEP"

	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
		if [ ! -d "$DEP_DEST" ]; then
			mkdir "$DEP_DEST"
		fi
		cp -rL "$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $DEP."
done


if [ $NOT_FOUND -gt 0 ]; then
	echo "Some dependencies were not found ($NOT_FOUND). Check the output above."
	exit 1
fi

echo "Successfully copied dependencies to '$ROOT_DIR'."
