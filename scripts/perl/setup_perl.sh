#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/copy_command.sh perl
$SCRIPT_DIR/mount_dev-null.sh
$SCRIPT_DIR/perl/add_perl_dependencies.sh
