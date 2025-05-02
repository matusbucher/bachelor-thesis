#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

ROOT_DIR="/home/matus/testroot"
COMMAND=$1
COMMAND_PATH=$(which "$COMMAND")

if [ ! -f "$COMMAND_PATH" ]; then
    echo "Command '$COMMAND' not found."
    exit 1
fi

COMMAND_DEST="$ROOT_DIR$COMMAND_PATH"

mkdir -p "$(dirname "$COMMAND_DEST")"
cp "$COMMAND_PATH" "$COMMAND_DEST"
echo "Copied binary $COMMAND_PATH."

DEPENDENCIES=$(ldd "$COMMAND_PATH" | grep -o '/lib[^ ]*' | grep -v "not found")

for LIB in $DEPENDENCIES; do
    LIB_DEST="$ROOT_DIR$LIB"
    mkdir -p "$(dirname "$LIB_DEST")"
    cp "$LIB" "$LIB_DEST"
    echo "Copied library $LIB."
done

echo "Successfully copied '$COMMAND' and its dependencies to '$ROOT_DIR'."
