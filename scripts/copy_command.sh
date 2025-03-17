#!/bin/bash

# Check if the command argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

# Set the target root directory
ROOT_DIR="/home/matus/testroot"

# Get the command name and its absolute path
COMMAND=$1
COMMAND_PATH=$(which "$COMMAND")

# Check if the command exists
if [ ! -f "$COMMAND_PATH" ]; then
    echo "Command '$COMMAND' not found."
    exit 1
fi

# Determine the target path for the command in testroot
COMMAND_DEST="$ROOT_DIR$COMMAND_PATH"

# Create the necessary directory structure for the command
mkdir -p "$(dirname "$COMMAND_DEST")"

# Copy the command binary to the same directory structure within testroot
cp "$COMMAND_PATH" "$COMMAND_DEST"

echo "Copied binary $COMMAND_PATH."

# Get the dependencies of the command
DEPENDENCIES=$(ldd "$COMMAND_PATH" | grep -o '/lib[^ ]*' | grep -v "not found")

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

echo "Successfully copied '$COMMAND' and its dependencies to '$ROOT_DIR'."
