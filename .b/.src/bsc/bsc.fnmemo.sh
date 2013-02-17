#!/bin/sh

## bsc.fnmemo.sh
##
## a script to add brief memo to the target file
## in the form of file name added
##
## Fri Mar 23 00:42:03 KST 2012




_this_prog="$(basename $0)";




# file path
if [ $# -eq 0 ]; then
	echo "bFNM>>> File(s) should be specified as (an) argument(s)";
	echo "Terminate this program.";
	exit 1;
fi

_fp_list="$*";
for _fp in $_fp_list; do

	# file name (basename)
	if [ "X$(which basename)" = "X" ]; then
		_fn="$(echo "$_fp" | sed -e 's/\(.*\)\/\([^\/]*\)/\2/')";
	else
		_fn=`basename $_fp`;
	fi
	
	# directory name (dirname)
	if [ "X$(which dirname)" = "X" ]; then
		_dn="$(echo "$_fp" | sed -e 's/\(.*\)\/\([^\/]*\)/\1/')";
	else
		_dn=`dirname $_fp`;
	fi
	
	read -p "bFNM>>> type memo: " _m1
	#_m2=$(echo "$_m1" | sed -e 's/ /_/g')
	#_m2=$(echo "$_m1" | tr -s '\\\t`~!@#$%^&*()+-={}[]|:";[:punct:][:blank:]' '_')
	_m2=$(echo "$_m1" | tr -s '[:punct:][:blank:]' '_')
	
	case $_this_prog in
	"fnm1"|"fnm")
		_fn_with_memo="+{${_m2}}#${_fn}"
		;;
	"fnm2")
		_fn_with_memo="$_fn+{${_m2}}"
		;;
	*)
		echo ">>> Undefined command";
		exit 2;
	esac
	
	cd $_dn;
	
	_systype="`uname -s | sed -e 's/\([^-]*\).*/\1/g'`"
	echo $_systype
	if [ "X$_systype" = "XCYGWIN_NT" ]; then
		ln $_fn $_fn_with_memo;
	else
		ln -s $_fn $_fn_with_memo;
	fi
	
	echo "bFNM>>> $_dn/$_fn_with_memo";

done




