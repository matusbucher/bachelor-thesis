#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/copy_command.sh gcc
$SCRIPT_DIR/copy_command.sh as
$SCRIPT_DIR/copy_command.sh ld
$SCRIPT_DIR/copy_command.sh rm

$SCRIPT_DIR/gcc/add_dependencies.sh
