#!/bin/bash

ROOT_DIR="/home/matus/testroot"

MOD_DIR="/usr/lib/python3.12/"

declare -a MODULES=(
	"encodings"
	"socket.py"
	"selectors.py"
	"collections"
 	"keyword.py"
 	"operator.py"
 	"reprlib.py"
 	"enum.py"
 	"types.py"
 	"functools.py"
 	"subprocess.py"
 	"locale.py"
 	"re"
 	"copyreg.py"
 	"signal.py"
 	"threading.py"
 	"_weakrefset.py"
	"warnings.py"
	"contextlib.py"
)

for MOD in ${MODULES[@]}; do
	DEP="$MOD_DIR$MOD"
	DEP_DEST="$ROOT_DIR$DEP"

	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
		if [ ! -d "$DEP_DEST" ]; then
			mkdir "$DEP_DEST"
		fi
		cp -r "$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $MOD."
done

echo "Successfully copied dependencies of to '$ROOT_DIR'."
