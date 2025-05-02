#!/bin/bash

ROOT_DIR="/home/matus/testroot"
NOT_FOUND=0

MOD_DIR1="/usr/lib/ruby/3.2.0/"

declare -a MODULES1=(
	"delegate.rb"
	"forwardable.rb"
	"forwardable/impl.rb"
	"fileutils.rb"
	"irb.rb"
	"irb/color.rb"
	"irb/color_printer.rb"
	"irb/completion.rb"
	"irb/context.rb"
	"irb/easter-egg.rb"
	"irb/ext/save-history.rb"
	"irb/extend-command.rb"
	"irb/init.rb"
	"irb/input-method.rb"
	"irb/inspector.rb"
	"irb/lc/error.rb"
	"irb/locale.rb"
	"irb/magic-file.rb"
	"irb/output-method.rb"
	"irb/ruby-lex.rb"
	"irb/src_encoding.rb"
	"irb/version.rb"
	"irb/workspace.rb"
	"pp.rb"
	"prettyprint.rb"
	"rubygems.rb"
	"rubygems/basic_specification.rb"
	"rubygems/compatibility.rb"
	"rubygems/core_ext/kernel_gem.rb"
	"rubygems/core_ext/kernel_require.rb"
	"rubygems/defaults.rb"
	"rubygems/dependency.rb"
	"rubygems/deprecate.rb"
	"rubygems/errors.rb"
	"rubygems/exceptions.rb"
	"rubygems/path_support.rb"
	"rubygems/platform.rb"
	"rubygems/request_set.rb"
	"rubygems/request_set"
	"rubygems/requirement.rb"
	"rubygems/resolver.rb"
	"rubygems/resolver"
	"rubygems/source.rb"
	"rubygems/source"
	"rubygems/specification.rb"
	"rubygems/stub_specification.rb"
	"rubygems/text.rb"
	"rubygems/tsort.rb"
	"rubygems/tsort/lib/tsort.rb"
	"rubygems/unknown_command_spell_checker.rb"
	"rubygems/util.rb"
	"rubygems/util/list.rb"
	"rubygems/version.rb"
	"reline.rb"
	"reline/ansi.rb"
	"reline/config.rb"
	"reline/general_io.rb"
	"reline/history.rb"
	"reline/key_actor.rb"
	"reline/key_actor/base.rb"
	"reline/key_actor/emacs.rb"
	"reline/key_actor/vi_command.rb"
	"reline/key_actor/vi_insert.rb"
	"reline/key_stroke.rb"
	"reline/kill_ring.rb"
	"reline/line_editor.rb"
	"reline/terminfo.rb"
	"reline/unicode.rb"
	"reline/unicode/east_asian_width.rb"
	"reline/version.rb"
	"ripper.rb"
	"ripper/core.rb"
	"ripper/filter.rb"
	"ripper/lexer.rb"
	"ripper/sexp.rb"
	"set.rb"
	"tempfile.rb"
	"timeout.rb"
	"tmpdir.rb"
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


MOD_DIR2="/usr/lib/x86_64-linux-gnu/ruby/3.2.0/"

declare -a MODULES2=(
	"rbconfig.rb"
	"enc/encdb.so"
	"io/console.so"
	"io/wait.so"
	"monitor.so"
	"ripper.so"
	"socket.so"
)

for MOD in ${MODULES2[@]}; do
	DEP="$MOD_DIR2$MOD"

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

GEMS_DIR="/usr/lib/ruby/gems/3.2.0/"

declare -a GEMS=(
	"gems/irb-1.6.2"
	"specifications/default/io-console-0.6.0.gemspec"
	"specifications/default/irb-1.6.2.gemspec"
	"specifications/default/reline-0.3.2.gemspec"
)

for GEM in ${GEMS[@]}; do
	DEP="$GEMS_DIR$GEM"

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

	echo "Copied dependency $GEM."
done


if [ $NOT_FOUND -gt 0 ]; then
	echo "Some dependencies were not found ($NOT_FOUND). Check the output above."
	exit 1
fi

echo "Successfully copied dependencies to '$ROOT_DIR'."
