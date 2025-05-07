#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/copy_command.sh lua
$SCRIPT_DIR/add_shell.sh sh

$SCRIPT_DIR/lua/add_dependencies.sh
