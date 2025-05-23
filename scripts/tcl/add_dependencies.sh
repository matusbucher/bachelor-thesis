#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

TCL_DIR="/usr/share/tcltk/tcl8.6/"
echo "export TCL_LIBRARY=$TCL_DIR" >> "$ROOT_DIR/root/.bashrc"

declare -a MODULES=(
	"init.tcl"
)

for MOD in ${MODULES[@]}; do
	DEP="$TCL_DIR$MOD"

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

	echo "Copied dependency $MOD."
done


if [ $NOT_FOUND -gt 0 ]; then
	echo "Some dependencies were not found ($NOT_FOUND). Check the output above."
	exit 1
fi

echo "Successfully copied dependencies to '$ROOT_DIR'."
