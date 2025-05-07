#!/bin/bash

ROOT_DIR="/home/matus/testroot"
PROC_DIR="$ROOT_DIR/proc"

mkdir -p "$PROC_DIR"

if ! mountpoint -q "$PROC_DIR"; then
    echo "Mounting /proc inside chroot..."
    mount --bind /proc "$PROC_DIR"
else
    echo "/proc is already mounted."
fi
