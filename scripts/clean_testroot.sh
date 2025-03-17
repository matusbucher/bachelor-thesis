#!/bin/bash

ROOT_DIR=/home/matus/testroot
SCRIPT_DIR=/home/matus/scripts
REVERSESHELL_DIR=/home/matus/school/bachelor-thesis/reverseshell

echo "Unmounting devices..."

umount -l "$ROOT_DIR"/dev/*

echo "Removing old testroot..."

rm -r "$ROOT_DIR"

mkdir "$ROOT_DIR"

echo "Adding bash to testroot..."

$SCRIPT_DIR/add_shell.sh bash

echo "Adding make to testroot..."

$SCRIPT_DIR/copy_command.sh make

cp $REVERSESHELL_DIR/Makefile $ROOT_DIR/
cp $REVERSESHELL_DIR/configure $ROOT_DIR/

echo "Done cleaning."
