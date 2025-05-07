#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

declare -a LIBS=(
	"/usr/libexec/gcc/x86_64-linux-gnu/13/cc1"
	"/usr/lib/x86_64-linux-gnu/libisl.so.23"
	"/usr/lib/x86_64-linux-gnu/libmpc.so.3"
	"/usr/lib/x86_64-linux-gnu/libmpfr.so.6"
	"/usr/lib/x86_64-linux-gnu/libzstd.so.1"
	"/usr/lib/x86_64-linux-gnu/libgmp.so.10"
	"/usr/lib/x86_64-linux-gnu/libz.so.1"
	"/usr/lib/x86_64-linux-gnu/libm.so.6"
	"/usr/include/alloca.h"
	"/usr/include/stdlib.h"
	"/usr/include/unistd.h"
	"/usr/include/features.h"
	"/usr/include/features-time64.h"
	"/usr/include/stdc-predef.h"
	"/usr/include/stddef.h"
	"/usr/include/endian.h"
	"/usr/include/arpa/inet.h"
	"/usr/include/x86_64-linux-gnu/bits/libc-header-start.h"
	"/usr/include/x86_64-linux-gnu/bits/wordsize.h"
	"/usr/include/x86_64-linux-gnu/bits/timesize.h"
	"/usr/include/x86_64-linux-gnu/sys/cdefs.h"
	"/usr/include/x86_64-linux-gnu/bits/long-double.h"
	"/usr/include/x86_64-linux-gnu/gnu/stubs.h"
	"/usr/include/x86_64-linux-gnu/gnu/stubs-64.h"
	"/usr/include/x86_64-linux-gnu/bits/waitflags.h"
	"/usr/include/x86_64-linux-gnu/bits/waitstatus.h"
	"/usr/include/x86_64-linux-gnu/bits/floatn.h"
	"/usr/include/x86_64-linux-gnu/bits/floatn-common.h"
	"/usr/include/x86_64-linux-gnu/sys/types.h"
	"/usr/include/x86_64-linux-gnu/bits/types.h"
	"/usr/include/x86_64-linux-gnu/bits/typesizes.h"
	"/usr/include/x86_64-linux-gnu/bits/time64.h"
	"/usr/include/x86_64-linux-gnu/bits/types/clock_t.h"
	"/usr/include/x86_64-linux-gnu/bits/types/clockid_t.h"
	"/usr/include/x86_64-linux-gnu/bits/types/time_t.h"
	"/usr/include/x86_64-linux-gnu/bits/types/timer_t.h"
	"/usr/include/x86_64-linux-gnu/bits/stdint-intn.h"
	"/usr/include/x86_64-linux-gnu/bits/endian.h"
	"/usr/include/x86_64-linux-gnu/bits/endianness.h"
	"/usr/include/x86_64-linux-gnu/bits/byteswap.h"
	"/usr/include/x86_64-linux-gnu/bits/uintn-identity.h"
	"/usr/include/x86_64-linux-gnu/sys/select.h"
	"/usr/include/x86_64-linux-gnu/bits/select.h"
	"/usr/include/x86_64-linux-gnu/bits/types/sigset_t.h"
	"/usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h"
	"/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h"
	"/usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h"
	"/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h"
	"/usr/include/x86_64-linux-gnu/bits/thread-shared-types.h"
	"/usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h"
	"/usr/include/x86_64-linux-gnu/bits/atomic_wide_counter.h"
	"/usr/include/x86_64-linux-gnu/bits/struct_mutex.h"
	"/usr/include/x86_64-linux-gnu/bits/struct_rwlock.h"
)

for LIB in ${LIBS[@]}; do
	DEP="$LIB"

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

	echo "Copied dependency $LIB."
done


if [ $NOT_FOUND -gt 0 ]; then
	echo "Some dependencies were not found ($NOT_FOUND). Check the output above."
	exit 1
fi

echo "Successfully copied dependencies to '$ROOT_DIR'."
