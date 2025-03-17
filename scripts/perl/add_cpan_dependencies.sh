#!/bin/bash

ROOT_DIR="/home/matus/testroot"

LIB_DIR1="/usr/lib/x86_64-linux-gnu/perl-base/"

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
    DEP="$LIB_DIR1$MOD"
    DEP_DEST="$ROOT_DIR$DEP"

    if [ -f "$DEP_DEST" ] || [ -d "$DEP_DEST" ]; then
        continue
    fi

    if [ -f "$DEP" ] || [ -d "$DEP" ]; then
        mkdir -p "$(dirname "$DEP_DEST")"
        cp -r "$DEP" "$DEP_DEST"
        echo "Copied module $MOD."
        continue
    fi

    echo "Cannot find $DEP."
done


LIB_DIR2="/usr/share/perl/5.38/"

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
    DEP="$LIB_DIR2$MOD"
    DEP_DEST="$ROOT_DIR$DEP"

    if [ -f "$DEP_DEST" ] || [ -d "$DEP_DEST" ]; then
	continue
    fi

    if [ -f "$DEP" ] || [ -d "$DEP" ]; then
        mkdir -p "$(dirname "$DEP_DEST")"
        cp -r "$DEP" "$DEP_DEST"
        echo "Copied module $MOD."
        continue
    fi

    echo "Cannot find $DEP."
done


LIB_DIR3="/usr/lib/x86_64-linux-gnu/perl/5.38/"

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
    DEP="$LIB_DIR3$MOD"
    DEP_DEST="$ROOT_DIR$DEP"

    if [ -f "$DEP_DEST" ] || [ -d "$DEP_DEST" ]; then
        continue
    fi

    if [ -f "$DEP" ] || [ -d "$DEP" ]; then
        mkdir -p "$(dirname "$DEP_DEST")"
        cp -r "$DEP" "$DEP_DEST"
        echo "Copied module $MOD."
        continue
    fi

    echo "Cannot find $DEP."
done

echo "Successfully added dependencies to '$ROOT_DIR'."
