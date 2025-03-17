#!/bin/bash

ROOT_DIR="/home/matus/testroot"

DEV_NULL="$ROOT_DIR/dev/null"

if [ ! -d "$ROOT_DIR/dev" ]; then
    echo "Creating /dev directory inside chroot."
    mkdir -p "$ROOT_DIR/dev"
fi

if [ ! -e "$DEV_NULL" ]; then
    echo "Creating /dev/null inside chroot."
    mknod -m 666 "$DEV_NULL" c 1 3
fi

if ! mountpoint -q "$DEV_NULL"; then
    echo "Mounting /dev/null from the host system."
    mount --bind /dev/null "$DEV_NULL"
else
    echo "/dev/null is already mounted."
fi
