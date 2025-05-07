#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/copy_command.sh php
$SCRIPT_DIR/add_shell.sh sh

UTC_FILE="/usr/share/zoneinfo/UTC"
DEP_DEST="/home/matus/testroot$UTC_FILE"

mkdir -p "$(dirname "$DEP_DEST")"
cp "$UTC_FILE" "$DEP_DEST"
echo "Copied file $UTC_FILE."

echo "Successfully copied dependencies to '$ROOT_DIR'."
