#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <shell>"
    exit 1
fi

ROOT_DIR="/home/matus/testroot"
SHELL=$1
SHELL_PATH="/bin/$1"

if [ ! -f "$SHELL_PATH" ]; then
    echo "Shell '$SHELL' not found."
    exit 1
fi

SHELL_DEST="$ROOT_DIR$SHELL_PATH"

mkdir -p "$(dirname "$SHELL_DEST")"
cp "$SHELL_PATH" "$SHELL_DEST"
echo "Copied binary $SHELL_PATH."

DEPENDENCIES=$(ldd "$SHELL_PATH" | grep -o '/lib[^ ]*' | grep -v "not found")

for LIB in $DEPENDENCIES; do
    LIB_DEST="$ROOT_DIR$LIB"
    mkdir -p "$(dirname "$LIB_DEST")"
    cp "$LIB" "$LIB_DEST"
    echo "Copied library $LIB."
done

echo "Successfully copied '$SHELL' and its dependencies to '$ROOT_DIR'."
