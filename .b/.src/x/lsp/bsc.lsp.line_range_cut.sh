#!/bin/sh
_this_prog="bsc.lsp.line_range_cut.sh";
_ver="20130131_190356";
# read from stdin, write to stdout


if [ $# -eq 2 ]; then
	_offset=$1
	_len=$2
else
	echo "#>> ERROR: Two arguments (arg1:offset; arg2:len) required -- EXIT";
	exit 1;
fi
head -n $(expr $_offset + $_len - 1) | tail -n $_len
