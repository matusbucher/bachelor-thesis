#!/bin/bash

# Check if the binary argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <binary_path>"
    exit 1
fi

# Set the target root directory
ROOT_DIR="/home/matus/testroot"

# Get the binary name and its absolute path
BINARY_PATH=$1
BINARY_DEST="$ROOT_DIR$BINARY_PATH"

# Check if the binary exists
if [ ! -f "$BINARY_DEST" ]; then
    echo "Binary '$BINARY_DEST' not found."
    exit 1
fi

# Remove the binary from testroot
rm "$BINARY_DEST"

echo "Remmoved binary $BINARY_DEST."

# Get the dependencies of the binary
DEPENDENCIES=$(ldd "$BINARY_PATH" | grep -o '/lib[^ ]*')

# Copy each dependency to the same directory structure within testroot
for LIB in $DEPENDENCIES; do
    # Determine the target path for the library in testroot
    LIB_DEST="$ROOT_DIR$LIB"

    # Remove the library from testroot
    rm "$LIB_DEST"

    echo "Removed library $LIB_DEST."
done

echo "Successfully removed '$BINARY_PATH' and its dependencies from '$ROOT_DIR'."
