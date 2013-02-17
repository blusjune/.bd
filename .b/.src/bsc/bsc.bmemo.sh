#!/bin/sh
#
##_ver="20110928_112358";
##_ver="20121106_212127";
##_ver="20121211_010630";
#
# usage:
#	$ bmmc
#		// create new memo file without any tag
#	$ bmmc any_single_word
#		// create new memo file with any single-word tag
#	$ bmml any_single_word
#		// list any memo files which have the single-word tag
#	$ bmml any_single_word | grep 'specified_word' | bmmx
#		// search and edit the one or more memo files which have the specified_word
#


_fd="${HOME}/.b/x/sys/memo"
_editor="vi"
_printout="cat"


_ccmd_fp="$0"			# full path version of current command name
_ccmd_bn="`basename $_ccmd_fp`"	# basename version of current command name


bmm_create()
{
	_fn_hdr="bM_`date +%Y%m%d`"
	_fn="${_fn_hdr}#${_bmm_create__tag}.txt"
	_fdn="${_fd}/${_fn}"

	$_editor $_fdn
} # bmm_create()


bmm_edit()
{
	( cd $_fd;
	if [ "X$bmm_edit__kw" = "X" ]; then
		ls -1 $_fd;
	else
		set `ls -1  $_fd | grep "${bmm_edit__kw}"`
		for _file in $*
		do
			$_editor $_file
		done
	fi
	)
} # bmm_edit()


bmm_list()
{
	if [ "X$bmm_list__kw" = "X" ]; then
		ls -1 $_fd;
	else
		ls -1  $_fd | grep "$bmm_list__kw"
	fi
} # bmm_list()


bmm_print()
{
	( cd $_fd;
	if [ "X$bmm_print__kw" = "X" ]; then
		ls -1 $_fd;
	else
		set `ls -1  $_fd | grep "${bmm_print__kw}"`
		for _file in $*
		do
			$_printout $_file
		done
	fi
	)
} # bmm_print()


bmm_symlink()
{
	if [ "X$bmm_symlink__kw" = "X" ]; then
		ls -1 $_fd;
	else
		set `ls -1  $_fd | grep "${bmm_symlink__kw}"`
		for _file in $*
		do
			echo "create symlink -> $_file";
			ln -s $_fd/$_file;
		done
	fi
} # bmm_symlink()


case $_ccmd_bn in
"bmmc" | "bmmw") ## create/write new memo with a single-word tag
	if [ "X$1" = "X" ]; then
		_bmm_create__tag="";
	else
		_bmm_create__tag="$1";
	fi
	bmm_create;
;;
"bmme")	## edit existing memo matched with a tag
	if [ "X$1" = "X" ]; then
		bmm_edit__kw="";
	else
		bmm_edit__kw="$1";
	fi
	bmm_edit;
;;
"bmml")	## list memo matched with a tag
	if [ "X$1" = "X" ]; then
		bmm_list__kw="";
	else
		bmm_list__kw="$1";
	fi
	bmm_list;
;;
"bmmp")	## print-out memo matched with a tag
	if [ "X$1" = "X" ]; then
		bmm_print__kw="";
	else
		bmm_print__kw="$1";
	fi
	bmm_print;
;;
"bmms")	## create symbolic link(s) to the memo matched with a tag
	if [ "X$1" = "X" ]; then
		bmm_symlink__kw="";
	else
		bmm_symlink__kw="$1";
	fi
	bmm_symlink;
;;
"bmm")
	echo "# Usage";
	echo "	bmm[c|e|l|p|s] [single-word tag]";
	echo "		bmmc: create new memo with a single-word tag";
	echo "		bmme: edit existing memo matched with a tag";
	echo "		bmml: list memo matched with a tag";
	echo "		bmmp: print (to stdout) memo matched with a tag";
	echo "		bmms: create symbolic link(s) to the memo matched with a tag";
	echo ""
	echo "# Information"
	echo "	bmemo archive path: $_fd"
	echo ""
;;
esac	




