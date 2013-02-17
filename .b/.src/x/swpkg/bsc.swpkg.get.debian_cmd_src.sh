#!/bin/sh

##bsc.swpkg.get.debian_cmd_src.sh
##tstamp: 20121204_031054
##_ver=20121212_214520


_this_prog="$(basename $0)";
_tstamp=$(tstamp);

if [ $# -eq 1 ]; then
	_cmd=$1; echo "#>> cmd you typed: '$_cmd'";
	_cmd_matched="$(which $_cmd)"; echo "#>> cmd matched: '$_cmd_matched'";
	_pkg=$(dpkg -S $_cmd_matched | sed -e 's/\([^:]*\):.*/\1/g');
	echo "#>> corresponding package name: '$_pkg'";

	read -p "#?? READY to go? [y|n] " _ans;
	if [ "X$_ans" != "Xy" ]; then
		echo "#>> You canceled -- EXIT";
		exit 0;
	fi
else
	echo "[usage] $_this_prog <command_name>";
	exit 0;
fi

_pkgdir="${_tstamp}.${_pkg}";
echo "#>> create directory '$_pkgdir' - to store the source code downloaded";
mkdir -p $_pkgdir;
( cd $_pkgdir; apt-get source $_pkg; )




