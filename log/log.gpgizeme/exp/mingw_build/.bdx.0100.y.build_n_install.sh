#!/bin/sh

_compiler="i686-w64-mingw32-gcc";
_target_dir="/x/t/share/swpkg/wintrace";
_build_target_conf=".target.cf";
_tstamp=$(..ts);

if [ ! -d $_target_dir ]; then
	mkdir -p $_target_dir;
fi
if [ ! -d $_target_dir ]; then
	echo "#>> ERROR: cannot create or access $_target_dir -- EXIT";
	exit 1;
else
	(cd $_target_dir; rm -f *.exe)
fi




if [ -r $_build_target_conf ]; then
	set `cat $_build_target_conf`;
else
	echo "#>> ERROR: '$_build_target_conf' file does not exist -- EXIT";
	exit 2;
fi
for _i in $*; do
	_src_file="${_i}.c"
	_exe_file="${_i}-${_tstamp}.exe"
	if [ -f $_exe_file ]; then
		rm $_exe_file;
	fi
	echo "BUILD> ${_exe_file} <- ${_src_file}";
	$_compiler -o ${_exe_file} ${_src_file};
	echo "       INSTALL> ${_target_dir}/${_exe_file}";
	cp -p $_exe_file $_target_dir;
	if [ -f ${_target_dir}/${_exe_file} ]; then
		echo "       REMOVE> '${_exe_file}' in current directory";
		rm $_exe_file;
	fi
done


