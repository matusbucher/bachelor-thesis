#!/bin/bash

ROOT_DIR=/home/matus/testroot
SCRIPT_DIR=/home/matus/scripts
REVERSESHELL_DIR=/home/matus/school/bachelor-thesis/reverseshell

echo "Unmounting /dev/*..."
umount -l "$ROOT_DIR"/dev/*

echo "Unmounting /proc..."
umount -l /path/to/chroot/proc

echo "Removing old testroot..."
rm -r "$ROOT_DIR"

echo "Creating new testroot..."
mkdir "$ROOT_DIR"

mkdir "$ROOT_DIR/tmp"
chmod 1777 "$ROOT_DIR/tmp"

mkdir "$ROOT_DIR/root"

$SCRIPT_DIR/add_shell.sh bash
$SCRIPT_DIR/copy_command.sh make

echo "Copying Makefile, configuration and source files to testroot..."
cp $REVERSESHELL_DIR/Makefile $ROOT_DIR/
cp $REVERSESHELL_DIR/configure $ROOT_DIR/
cp -rL $REVERSESHELL_DIR/src $ROOT_DIR/

echo "Done cleaning."
