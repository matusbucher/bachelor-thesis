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
	DEP="$MOD_DIR$MOD"
	DEP_DEST="$ROOT_DIR$DEP"

	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
		if [ ! -d "$DEP_DEST" ]; then
			mkdir "$DEP_DEST"
		fi
		cp -r "$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $MOD."
done

echo "Successfully copied dependencies to '$ROOT_DIR'."
