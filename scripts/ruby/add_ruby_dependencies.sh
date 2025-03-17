#!/bin/bash

ROOT_DIR="/home/matus/testroot"

MOD_DIR1="/usr/lib/ruby/3.2.0/"

declare -a MODULES1=(
	"socket.rb"
)

for MOD in ${MODULES1[@]}; do
    DEP="$MOD_DIR1$MOD"
    DEP_DEST="$ROOT_DIR$DEP"
    mkdir -p "$(dirname "$DEP_DEST")"

    if [ -d "$DEP" ]; then
	cp -r "$DEP" "$DEP_DEST"
    else
	cp "$DEP" "$DEP_DEST"
    fi

    echo "Copied module $MOD."
done


MOD_DIR2="/usr/lib/x86_64-linux-gnu/ruby/3.2.0/"

declare -a MODULES2=(
	"socket.so"
)

for MOD in ${MODULES2[@]}; do
    DEP="$MOD_DIR2$MOD"
    DEP_DEST="$ROOT_DIR$DEP"
    mkdir -p "$(dirname "$DEP_DEST")"

    if [ -d "$DEP" ]; then
        cp -r "$DEP" "$DEP_DEST"
    else
        cp "$DEP" "$DEP_DEST"
    fi

    echo "Copied module $MOD."
done

echo "Successfully copied dependencies to '$ROOT_DIR'."
