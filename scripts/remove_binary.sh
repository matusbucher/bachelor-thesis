#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <binary_path>"
    exit 1
fi

ROOT_DIR="/home/matus/testroot"
BINARY_PATH=$1
BINARY_DEST="$ROOT_DIR$BINARY_PATH"

if [ ! -f "$BINARY_DEST" ]; then
    echo "Binary '$BINARY_DEST' not found."
    exit 1
fi

rm "$BINARY_DEST"
echo "Remmoved binary $BINARY_DEST."

DEPENDENCIES=$(ldd "$BINARY_PATH" | grep -o '/lib[^ ]*')

for LIB in $DEPENDENCIES; do
    LIB_DEST="$ROOT_DIR$LIB"
    rm "$LIB_DEST"
    echo "Removed library $LIB_DEST."
done

echo "Successfully removed '$BINARY_PATH' and its dependencies from '$ROOT_DIR'."
