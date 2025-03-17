#!/bin/bash

SCRIPT_DIR=/home/matus/scripts

$SCRIPT_DIR/copy_command.sh cpan
$SCRIPT_DIR/perl/add_perl_dependencies.sh
$SCRIPT_DIR/perl/add_cpan_dependencies.sh
