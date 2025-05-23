#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/copy_command.sh javac
$SCRIPT_DIR/copy_command.sh java
$SCRIPT_DIR/copy_command.sh rm

$SCRIPT_DIR/javac/add_dependencies.sh
