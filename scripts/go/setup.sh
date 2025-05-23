#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/mount_dev_device.sh null 1 3

$SCRIPT_DIR/copy_command.sh go
$SCRIPT_DIR/copy_command.sh rm

$SCRIPT_DIR/go/add_dependencies.sh
