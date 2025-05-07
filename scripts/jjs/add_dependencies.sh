#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

JAVA_LIB_DIR="/usr/lib/jvm/java-11-openjdk-amd64/lib/"

declare -a LIBS=(
	"jli/libjli.so"
	"libjava.so"
	"jvm.cfg"
	"server/libjvm.so"
	"libverify.so"
	"libjimage.so"
	"libzip.so"
)

for LIB in ${LIBS[@]}; do
	DEP="$JAVA_LIB_DIR$LIB"

	if [ ! -e "$DEP" ]; then
		echo "Dependency $DEP not found. Skipping..."
		NOT_FOUND=$((NOT_FOUND + 1))
		continue
	fi

	DEP_DEST="$ROOT_DIR$DEP"
	
	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
		if [ ! -d "$DEP_DEST" ]; then
			mkdir "$DEP_DEST"
		fi
		cp -rL "$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $LIB."
done

declare -a DEPS=(
	"/usr/lib/x86_64-linux-gnu/libstdc++.so.6"
	"/usr/lib/x86_64-linux-gnu/libm.so.6"
	"/usr/lib/x86_64-linux-gnu/libgcc_s.so.1"
)

for DEP in ${DEPS[@]}; do
	if [ ! -e "$DEP" ]; then
		echo "Dependency $DEP not found. Skipping..."
		NOT_FOUND=$((NOT_FOUND + 1))
		continue
	fi
	
	DEP_DEST="$ROOT_DIR$DEP"

	mkdir -p "$(dirname "$DEP_DEST")"

        if [ -d "$DEP" ]; then
                if [ ! -d "$DEP_DEST" ]; then
                        mkdir "$DEP_DEST"
                fi
                cp -rL "$DEP/"* "$DEP_DEST/"
        else
                cp "$DEP" "$DEP_DEST"
        fi

        echo "Copied dependency $DEP."
done


if [ $NOT_FOUND -gt 0 ]; then
	echo "Some dependencies were not found ($NOT_FOUND). Check the output above."
	exit 1
fi

echo "Successfully copied dependencies to '$ROOT_DIR'."
