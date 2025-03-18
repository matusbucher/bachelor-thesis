#!/bin/bash

ROOT_DIR=/home/matus/testroot
SCRIPT_DIR=/home/matus/scripts
REVERSESHELL_DIR=/home/matus/school/bachelor-thesis/reverseshell

echo "Unmounting devices..."
umount -l "$ROOT_DIR"/dev/*

echo "Removing old testroot..."
rm -r "$ROOT_DIR"

echo "Creating new testroot..."
mkdir "$ROOT_DIR"

$SCRIPT_DIR/add_shell.sh bash
$SCRIPT_DIR/copy_command.sh make

echo "Copying Makefile and configuration file to testroot..."
cp $REVERSESHELL_DIR/Makefile $ROOT_DIR/
cp $REVERSESHELL_DIR/configure $ROOT_DIR/

echo "Done cleaning."
