#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

JAVA_DIR="/usr/lib/jvm/java-21-openjdk-amd64/"

SEC="${JAVA_DIR}conf/security/java.security"
if [ ! -e "$SEC" ]; then
	echo "Dependency $SEC not found. Skipping..."
	NOT_FOUND=$((NOT_FOUND + 1))
	continue
fi

SEC_DEST="$ROOT_DIR$SEC"
mkdir -p "$(dirname "$SEC_DEST")"
cp "$SEC" "$SEC_DEST"
echo "Copied dependency $SEC."

JAVA_LIB_DIR="${JAVA_DIR}lib/"
echo "export LD_LIBRARY_PATH=$JAVA_LIB_DIR" >> "$ROOT_DIR/root/.bashrc"

declare -a JAVA_FILES=(
	"libextnet.so"
	"libjava.so"
	"libjimage.so"
	"libjli.so"
	"libnet.so"
	"libnio.so"
	"server/libjvm.so"
	"jvm.cfg"
	"jspawnhelper"
	"modules"
)

for LIB in ${JAVA_FILES[@]}; do
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

	echo "Copied dependency $DEP."
done


LIB_DIR="/usr/lib/x86_64-linux-gnu/"

declare -a LIBS=(
	"libstdc++.so.6"
	"libm.so.6"
	"libgcc_s.so.1"
)

for LIB in ${LIBS[@]}; do
	DEP="$LIB_DIR$LIB"

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
