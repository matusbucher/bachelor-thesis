#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

MOD_DIR1="/usr/lib/x86_64-linux-gnu/perl-base/"

declare -a MODULES1=(
	"File/Spec.pm"
	"File/Spec/Unix.pm"
	"Tie/Hash.pm"
	"Exporter/Heavy.pm"
	"Cwd.pm"
	"constant.pm"
	"Symbol.pm"
	"POSIX.pm"
	"Fcntl.pm"
	"overload.pm"
	"overloading.pm"
	"builtin.pm"
	"utf8.pm"
	"re.pm"
	"lib.pm"
	"Errno.pm"
	"FileHandle.pm"
	"SelectSaver.pm"
	"IO.pm"
	"IO/File.pm"
	"IO/Seekable.pm"
	"IO/Handle.pm"
	"Text/ParseWords.pm"
	"Text/Wrap.pm"
	"Text/Tabs.pm"
	"Scalar/Util.pm"
	"Config_heavy.pl"
	"Config_git.pl"
	"auto/IO/IO.so"
	"auto/Cwd/Cwd.so"
	"auto/Fcntl/Fcntl.so"
	"auto/POSIX/POSIX.so"
	"auto/re/re.so"
)

for MOD in ${MODULES1[@]}; do
	DEP="$MOD_DIR1$MOD"

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
		cp -r "$DEP/"* "$DEP_DEST/"
	else
		cp "$DEP" "$DEP_DEST"
	fi

	echo "Copied dependency $MOD."
done


MOD_DIR2="/usr/share/perl/5.38/"

declare -a MODULES2=(
	"App/Cpan.pm"
	"if.pm"
	"autouse.pm"
	"subs.pm"
	"version"
	"version.pm"
	"version.pod"
	"Safe.pm"
	"CPAN.pm"
	"CPAN/Author.pm"
	"CPAN/InfoObj.pm"
	"CPAN/Debug.pm"
	"CPAN/HandleConfig.pm"
	"CPAN/Version.pm"
	"CPAN/Bundle.pm"
	"CPAN/Module.pm"
	"CPAN/CacheMgr.pm"
	"CPAN/Complete.pm"
	"CPAN/Distribution.pm"
	"CPAN/Distroprefs.pm"
	"CPAN/Distrostatus.pm"
	"CPAN/Index.pm"
	"CPAN/Prompt.pm"
	"CPAN/Queue.pm"
	"CPAN/Tarzip.pm"
	"CPAN/DeferredCode.pm"
	"CPAN/URL.pm"
	"CPAN/Shell.pm"
	"CPAN/FTP.pm"
	"CPAN/FTP/netrc.pm"
	"CPAN/LWP/UserAgent.pm"
	"CPAN/HTTP/Credentials.pm"
	"CPAN/Exception/RecursiveDependency.pm"
	"CPAN/Exception/yaml_not_installed.pm"
	"CPAN/Exception/yaml_process_error.pm"
	"CPAN/FirstTime.pm"
	"CPAN/Mirrors.pm"
	"File/Path.pm"
	"File/Path.pm"
	"File/Basename.pm"
	"File/Find.pm"
	"File/Copy.pm"
	"ExtUtils/MakeMaker.pm"
	"ExtUtils/MakeMaker/Config.pm"
	"ExtUtils/MakeMaker/version.pm"
	"ExtUtils/MM.pm"
	"ExtUtils/MM_Unix.pm"
	"ExtUtils/MM_Any.pm"
	"ExtUtils/MY.pm"
	"ExtUtils/Liblist.pm"
	"ExtUtils/Liblist/Kid.pm"
	"Getopt/Std.pm"
	"Net/Ping.pm"
	"Term/ReadLine.pm"
	"DirHandle.pm"
)

for MOD in ${MODULES2[@]}; do
	DEP="$MOD_DIR2$MOD"
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


MOD_DIR3="/usr/lib/x86_64-linux-gnu/perl/5.38/"

declare -a MODULES3=(
	"B.pm"
	"Opcode.pm"
	"Sys/Hostname.pm"
	"File/Spec/Functions.pm"
	"Time/HiRes.pm"
	"auto/B/B.so"
	"auto/Opcode/Opcode.so"
	"auto/Sys/Hostname/Hostname.so"
)

for MOD in ${MODULES3[@]}; do
	DEP="$MOD_DIR3$MOD"
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


if [ $NOT_FOUND -gt 0 ]; then
	echo "Some dependencies were not found ($NOT_FOUND). Check the output above."
	exit 1
fi

echo "Successfully added dependencies to '$ROOT_DIR'."
