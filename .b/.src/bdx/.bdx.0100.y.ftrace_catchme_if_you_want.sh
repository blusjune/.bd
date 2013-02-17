#!/bin/sh
##.bdx.0100.y.ftrace_catchme_if_you_want.sh
##_ver=20121212_162434




_FTcfg_sfp="tracing/set_ftrace_pid";
_FTcmd_flush_and_turnoff="./_FTcmd.flush_and_turnoff.sh";
_FTcmd_restart="./_FTcmd.restart.sh";
_catchme_file_default="catchme.sh";




echo "=========================";
read -p "#?? script file to exec: " _catchme_file;
if [ "X$_catchme_file" = "X" ]; then
	echo "#>> '$_catchme_file_default' (by default, if exists) will be executed";
	_catchme_file="$_catchme_file_default";
else
	echo "#>> '$_catchme_file' will be executed";
fi
if [ ! -f $_catchme_file ]; then
	echo "#>> ERROR: '$_catchme_file' does not exist -- EXIT";
	exit 1;
else
	_te1="$(cat $_catchme_file | grep _FTcmd | grep restart | wc -l)";
	if [ "X$_te1" = "0" ]; then
		echo "#>> ERROR: '$_catchme_file' does not contain '$_FTcmd_restart' line -- EXIT";
		exit 1;
	fi
	_te2="$(cat $_catchme_file | grep _FTcmd | grep flush_and_turnoff | wc -l)";
	if [ "X$_te2" = "0" ]; then
		echo "#>> ERROR: '$_catchme_file' does not contain '$_FTcmd_flush_and_turnoff' line -- EXIT";
		exit 1;
	fi
	echo "#>> OK, $_catchme_file contains 'FT restart / flush-and-turnoff'";
fi


echo "-------------------------";
_mypid="$$";
echo "#>> PID for Ftracing: $_mypid";
$_FTcmd_flush_and_turnoff;
echo $_mypid > $_FTcfg_sfp;


echo "-------------------------";
read -p "#?? ready to go? (and FTLOG ready?) [y|n]" _ans;
if [ "X$_ans" = "Xy" ]; then

##
## ---------------------------------------------------------------------------------------
## '_FTcmd_restart' should be called inside _catchme_file right before 'the very' action

	. $_catchme_file;	# SHOULD be sourced like this way; DON'T execute directly.

## '_FTcmd_flush_and_turnoff' should be called right after 'the very' action
## ---------------------------------------------------------------------------------------
##

else
	echo "#>> You canceled -- EXIT";
	exit 0;
fi




$_FTcmd_flush_and_turnoff;
echo "=========================";




#exec hdparm --fibmap 8xhosts;
#exec hdparm --please-destroy-my-drive --trim-sector-ranges 84154368:4 /dev/sdb




