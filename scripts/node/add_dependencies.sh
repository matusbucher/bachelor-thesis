#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

NODE_DIR="/usr/share/nodejs"

declare -a LIBS=(
	"/cjs-module-lexer/lexer.js"
	"/cjs-module-lexer/dist/lexer.js"
	"/undici/undici-fetch.js"
	"/acorn/dist/acorn.js"
	"/acorn-walk/dist/walk.js"
)

for LIB in ${LIBS[@]}; do
	DEP="$NODE_DIR$LIB"

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
		cp -rL"$DEP/"* "$DEP_DEST/"
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
