#!/bin/bash

# Check if the command argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <binary>"
    exit 1
fi

ROOT_DIR="/home/matus/testroot"

BINARY=$1

if [ ! -f "$BINARY" ]; then
    echo "Binary '$BINARY' not found."
    exit 1
fi

DEPENDENCIES=$(ldd "$BINARY" | grep -o '/lib[^ ]*' | grep -v "not found")

# Copy each dependency to the same directory structure within testroot
for LIB in $DEPENDENCIES; do
    # Determine the target path for the library in testroot
    LIB_DEST="$ROOT_DIR$LIB"

    # Create the necessary directory structure for the library
    mkdir -p "$(dirname "$LIB_DEST")"

    # Copy the library to the target path
    cp "$LIB" "$LIB_DEST"

    echo "Copied library $LIB."
done

echo "Successfully copied dependencies of '$BINARY' to '$ROOT_DIR'."
