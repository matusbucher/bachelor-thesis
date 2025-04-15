#!/bin/bash

DEVICE_NAME="$1"
MAJOR="$2"
MINOR="$3"

if [ -z "$DEVICE_NAME" ] || [ -z "$MAJOR" ] || [ -z "$MINOR" ]; then
    echo "Usage: $0 <device_name> <major> <minor>"
    exit 1
fi

ROOT_DIR="/home/matus/testroot"
DEV_PATH="$ROOT_DIR/dev/$DEVICE_NAME"

mkdir -p "$ROOT_DIR/dev"

if [ ! -e "$DEV_PATH" ]; then
    echo "Creating /dev/$DEVICE_NAME inside chroot..."
    mknod -m 666 "$DEV_PATH" c "$MAJOR" "$MINOR"
fi

if ! mountpoint -q "$DEV_PATH"; then
    echo "Mounting /dev/$DEVICE_NAME from the host system..."
    mount --bind "/dev/$DEVICE_NAME" "$DEV_PATH"
else
    echo "/dev/$DEVICE_NAME is already mounted."
fi
