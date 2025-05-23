#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

MOD_DIR1="/usr/lib/python3.12/"

declare -a MODULES1=(
	"typing.py"
	"logging"
	"traceback.py"
	"linecache.py"
	"tokenize.py"
	"token.py"
	"textwrap.py"
	"weakref.py"
	"string.py"
	"optparse.py"
	"pathlib.py"
	"fnmatch.py"
	"urllib"
	"ipaddress.py"
	"__future__.py"
	"glob.py"
	"importlib"
	"tempfile.py"
	"random.py"
	"bisect.py"
	"inspect.py"
	"ast.py"
	"dis.py"
	"opcode.py"
	"copy.py"
	"pprint.py"
	"dataclasses.py"
	"html"
	"datetime.py"
	"platform.py"
	"sysconfig.py"
	"struct.py"
	"pickle.py"
	"_compat_pickle.py"
	"queue.py"
	"heapq.py"
	"getpass.py"
	"colorsys.py"
	"configparser.py"
	"fractions.py"
	"decimal.py"
	"numbers.py"
	"contextvars.py"
	"hashlib.py"
	"shutil.py"
	"json"
	"concurrent"
	"asyncio"
	"http"
	"email"
	"base64.py"
	"quopri.py"
	"calendar.py"
	"hmac.py"
	"mimetypes.py"
	"zipfile"
	"stringprep.py"
	"_sysconfigdata__x86_64-linux-gnu.py"
	"csv.py"
	"shlex.py"
	"socketserver.py"
	"_markupbase.py"
	"uuid.py"
	"compileall.py"
	"py_compile.py"
	"filecmp.py"
	"xmlrpc"
	"xml"
	"pkgutil.py"
	"tarfile.py"
	"argparse.py"
	"plistlib.py"
	"ssl.py"
	"warnings.py"
	"threading.py"
	"subprocess.py"
	"signal.py"
	"re"
	"copyreg.py"
	"contextlib.py"
	"_weakrefset.py"
	"locale.py"
	"getopt.py"
)

for MOD in ${MODULES1[@]}; do
	DEP="$MOD_DIR1$MOD"

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


LIB_DIR="/usr/lib/python3.12/lib-dynload/"

declare -a LIBS=(
	"mmap.cpython-312-x86_64-linux-gnu.so"
	"_decimal.cpython-312-x86_64-linux-gnu.so"
	"_contextvars.cpython-312-x86_64-linux-gnu.so"
)

for LIB in ${LIBS[@]}; do
	DEP="$LIB_DIR$LIB"

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


MOD_DIR2="/usr/lib/python3/dist-packages/"

declare -a MODULES2=(
	"_distutils_hack"
	"pip"
	"setuptools"
	"wheel"
)

for MOD in ${MODULES2[@]}; do
	DEP="$MOD_DIR2$MOD"

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
