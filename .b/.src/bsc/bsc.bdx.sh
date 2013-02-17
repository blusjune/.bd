#!/bin/sh
## bsc.bdx.sh
## Beee's Directory eXecution (BDX) framework
## 20120930_225848


## BDX file name format standard
## .bdx.0001.y.script_to_execute.sh
## .bdx.0002.n.script_to_skip.sh


_tstamp=$(date +%Y%m%d_%H%M%S);
_this_prog=$(basename $0);


_bdx_print_help ()
{

	echo "[Usage]"
	echo "	$_this_prog";
	echo "	$_this_prog -h|--help";
	echo "	$_this_prog -d|--dir <directory_to_execute_bdx>";
	echo "";
	echo "[Tip] BDX file name format standard";
	echo "	bdx_file_name ::= '.bdx' '.' ['y'|'n'] '.' <name> '.sh'";
	echo "	ex1) .bdx.0001.y.script_to_execute.sh";
	echo "	ex2) .bdx.0002.n.script_to_skip.sh";
	echo "";
}


_bdx_exec_bdx_files ()
{
	for _bdx_file in $(ls -1 .bdx.*.sh)
	do
	# echo $_bdx_file | sed -e 's/\.bdx\.\([0-9]*\)\.\([yn]\)\.\(.*\)\.sh/sn=\1 flag=\2 base=\3/g'
		_bdx_sn=$(echo $_bdx_file | sed -e 's/\.bdx\.\([0-9]*\)\.\([yn]\)\.\(.*\)\.sh/\1/g');
		_bdx_flag=$(echo $_bdx_file | sed -e 's/\.bdx\.\([0-9]*\)\.\([yn]\)\.\(.*\)\.sh/\2/g');
		_bdx_radix=$(echo $_bdx_file | sed -e 's/\.bdx\.\([0-9]*\)\.\([yn]\)\.\(.*\)\.sh/\3/g');
		if [ "X${_bdx_flag}" = "Xy" ]; then
			echo "BDX[ $(pwd) ]# ${_bdx_sn} : ${_bdx_radix}";
			. ${_bdx_file};
		fi
	done
}




## main call
case $# in
	"1")
		if [ "X$1" = "X-h" -o "X$1" = "X--help" ]; then
			_bdx_print_help;
			exit 0;
		else
			echo ">>> ERROR: invalid arguments";
			_bdx_print_help;
			exit 1;
		fi
		;;
	"2")
		case "X$1" in
			"X-d"|"X--dir")
				_bdx_dir="$2";
				(cd $_bdx_dir; _bdx_exec_bdx_files;)
				;;
			*)
				echo ">>> ERROR: invalid arguments";
				_bdx_print_help;
				exit 1;
				;;
		esac
		;;
	*)
		_bdx_exec_bdx_files;
		;;
esac




