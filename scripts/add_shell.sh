#!/bin/bash

# Check if the shell argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <shell>"
    exit 1
fi

# Set the target root directory
ROOT_DIR="/home/matus/testroot"

# Get the shell name and its absolute path
SHELL=$1
SHELL_PATH="/bin/$1"

# Check if the shell exists
if [ ! -f "$SHELL_PATH" ]; then
    echo "Shell '$SHELL' not found."
    exit 1
fi

# Determine the target path for the shell in testroot
SHELL_DEST="$ROOT_DIR$SHELL_PATH"

# Create the necessary directory structure for the shell
mkdir -p "$(dirname "$SHELL_DEST")"

# Copy the shell binary to the same directory structure within testroot
cp "$SHELL_PATH" "$SHELL_DEST"

echo "Copied binary $SHELL_PATH."

# Get the dependencies of the shell
DEPENDENCIES=$(ldd "$SHELL_PATH" | grep -o '/lib[^ ]*' | grep -v "not found")

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

echo "Successfully copied '$SHELL' and its dependencies to '$ROOT_DIR'."
