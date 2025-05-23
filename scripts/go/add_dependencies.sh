#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

GO_DIR="/usr/lib/go"
echo "export GOROOT=$GO_DIR" >> "$ROOT_DIR/root/.bashrc"

declare -a DEPS=(
	"pkg/include/asm_amd64.h"
	"pkg/include/funcdata.h"
	"pkg/include/textflag.h"
	"pkg/tool/linux_amd64/asm"
	"pkg/tool/linux_amd64/compile"
	"pkg/tool/linux_amd64/link"
)

for D in ${DEPS[@]}; do
	DEP="$GO_DIR/$D"

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


GO_MOD_DIR="$GO_DIR/src"

declare -a MODS=(
	"bytes"
	"context"
	"cmp"
	"errors"
	"internal/abi"
	"internal/bisect"
	"internal/bytealg"
	"internal/cpu"
	"internal/chacha8rand"
	"internal/coverage/rtcov"
	"internal/goarch"
	"internal/godebugs"
	"internal/goexperiment"
	"internal/goos"
	"internal/godebug"
	"internal/itoa"
	"internal/intern"
	"internal/oserror"
	"internal/nettrace"
	"internal/reflectlite"
	"internal/race"
	"internal/poll"
	"internal/syscall/unix"
	"internal/singleflight"
	"internal/safefilepath"
	"internal/syscall/execenv"
	"internal/testlog"
	"internal/unsafeheader"
	"io"
	"io/fs"
	"os"
	"os/exec"
	"math"
	"math/bits"
	"path"
	"path/filepath"
	"net"
	"net/netip"
	"runtime"
	"runtime/internal/atomic"
	"runtime/internal/math"
	"runtime/internal/sys"
	"runtime/internal/syscall"
	"sync"
	"sync/atomic"
	"syscall"
	"sort"
	"strconv"
	"slices"
	"strings"
	"time"
	"unsafe"
	"unicode"
	"unicode/utf8"
	"vendor"
)

for MOD in ${MODS[@]}; do
	DEP="$GO_MOD_DIR/$MOD"

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
