#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/copy_command.sh pip
$SCRIPT_DIR/copy_command.sh mkdir
$SCRIPT_DIR/copy_command.sh rm
$SCRIPT_DIR/python3/setup.sh
$SCRIPT_DIR/pip/add_dependencies.sh
