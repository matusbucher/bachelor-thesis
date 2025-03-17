#!/bin/bash

ROOT_DIR="/home/matus/testroot"

PERL_DIR="/usr/lib/x86_64-linux-gnu/perl-base/"

declare -a MODULES=(
	"Socket.pm"
	"strict.pm"
 	"Carp.pm"
	"warnings.pm"
	"warnings/register.pm"
	"Exporter.pm"
 	"XSLoader.pm"
	"DynaLoader.pm"
	"vars.pm"
	"Config.pm"
	"auto/Socket/Socket.so"
)

for MOD in ${MODULES[@]}; do
    DEP="$PERL_DIR$MOD"
    DEP_DEST="$ROOT_DIR$DEP"

    if [ ! -f "$DEP" ]; then
        echo "Cannot find $DEP."
        continue
    fi

    mkdir -p "$(dirname "$DEP_DEST")"
    cp -r "$DEP" "$DEP_DEST"
    echo "Copied module $MOD."
done

echo "Successfully copied dependencies to '$ROOT_DIR'."
