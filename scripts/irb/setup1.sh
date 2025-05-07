#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/mount_dev-null.sh
$SCRIPT_DIR/copy_command.sh irb
$SCRIPT_DIR/copy_command.sh ruby3.2
$SCRIPT_DIR/irb/add_dependencies.sh
