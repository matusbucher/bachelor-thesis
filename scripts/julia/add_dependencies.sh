#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

JULIA_DIR="/opt/julia"

declare -a LIBS=(
	"/lib/libjulia.so.1.11"
	"/lib/julia/libgcc_s.so.1"
	"/lib/julia/libopenlibm.so"
	"/lib/julia/libstdc++.so.6"
	"/lib/julia/libjulia-internal.so.1.11"
	"/lib/julia/libunwind.so.8"
	"/lib/julia/libz.so.1"
	"/lib/julia/libatomic.so.1"
	"/lib/julia/libjulia-codegen.so.1.11"
	"/lib/julia/libLLVM-16jl.so"
	"/lib/julia/sys.so"
	"/lib/julia/libpcre2-8.so"
	"/lib/julia/libmpfr.so.6"
	"/lib/julia/libgmp.so.10"
	"/lib/julia/libgfortran.so.5"
	"/lib/julia/libquadmath.so.0"
	"/lib/julia/libopenblas64_.so"
	"/lib/julia/libblastrampoline.so.5"
)

for LIB in ${LIBS[@]}; do
	DEP="$JULIA_DIR$LIB"

	if [ ! -e "$DEP" ]; then
		echo "Dependency $DEP not found. Skipping..."
		NOT_FOUND=$((NOT_FOUND + 1))
		continue
	fi

	DEP_DEST="$ROOT_DIR/usr/local$LIB"

	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
		if [ ! -d "$DEP_DEST" ]; then
			mkdir "$DEP_DEST"
		fi
		cp -rL"$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $LIB."
done

MOD_DIR="/share/julia/stdlib/v1.11"
JULIA_MOD_DIR="$JULIA_DIR$MOD_DIR"

declare -a MODS=(
	"/Sockets/src/Sockets.jl"
        "/Sockets/Project.toml"
)

for MOD in ${MODS[@]}; do
	DEP="$JULIA_MOD_DIR$MOD"

	if [ ! -e "$DEP" ]; then
		echo "Dependency $DEP not found. Skipping..."
		NOT_FOUND=$((NOT_FOUND + 1))
		continue
	fi

	DEP_DEST="$ROOT_DIR/usr/local$MOD_DIR$MOD"

	mkdir -p "$(dirname "$DEP_DEST")"

	if [ -d "$DEP" ]; then
			if [ ! -d "$DEP_DEST" ]; then
					mkdir "$DEP_DEST"
			fi
			cp -rL"$DEP/"* "$DEP_DEST/"
	else
			cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $MOD."
done


declare -a DEPS2=(
	"/lib/x86_64-linux-gnu/libm.so.6"
	"/lib/x86_64-linux-gnu/librt.so.1"
)

for DEP in ${DEPS2[@]}; do
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
                cp -rL"$DEP/"* "$DEP_DEST/"
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
