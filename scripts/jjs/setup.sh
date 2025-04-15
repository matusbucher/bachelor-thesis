#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/copy_command.sh /usr/lib/jvm/java-11-openjdk-amd64/bin/jjs
$SCRIPT_DIR/jjs/add_dependencies.sh
