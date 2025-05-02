#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/mount_proc.sh
$SCRIPT_DIR/copy_command.sh julia
$SCRIPT_DIR/julia/add_dependencies.sh
