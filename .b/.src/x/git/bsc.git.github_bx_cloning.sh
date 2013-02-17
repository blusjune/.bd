#!/bin/sh
## .b_x git-cloning
##tstamp: 20120824_000142
##tstamp: 20121026_003447
##tstamp: 20121121_003105
##_ver="20121208_141916"; 
_ver="20121208_141916"; 




_tstamp="$(tstamp)";
_this_prog="$(basename $0)";

_print_help()
{
	echo "_this_prog [ver:$_ver]";
	echo "[Usage] bsc.github.bx_cloning_rw <git_target>";
	echo "[Usage] bsc.github.bx_cloning_ro <git_target>";
	echo "[Usage] $_this_prog <git_target>";
	echo "	, where <git_target>: all | .bd | .blib | .bkrnl | .b_src";
}

_git_cloning()
{
	if [ "X${_td}" != "X" ]; then
		_cmd__git_clone_rw="git clone https://github.com/blusjune/${_td}.git"	## read-write
		_cmd__git_clone_ro="git clone git://github.com/blusjune/${_td}.git"	## read-only
		if [ -d ${_td} ]; then
			mv ${_td} ${_td}.old.${_tstamp};
		fi
		case "X$_this_prog" in
			"Xbsc.github.bx_cloning_ro")
				$_cmd__git_clone_ro;
				;;
			"Xbsc.github.bx_cloning_rw"|"Xbsc.github.bx_cloning")
				$_cmd__git_clone_rw;
				;;
			*)
				$_cmd__git_clone_rw;
				;;
		esac
	else
		echo ">>> ERROR: _td is not set";
		exit 1;
	fi
}

if [ $# -eq 1 ]; then
	_target="$1";
	case $_target in
		".bd.git"|".bd"|"bd")
			echo ">>> _td=\".bd\"; _git_cloning;"
			_td=".bd"; _git_cloning;
			;;
		".blib.git"|".blib"|"blib")
			echo ">>> _td=\".blib\"; _git_cloning;"
			_td=".blib"; _git_cloning;
			;;
		".bkrnl.git"|".bkrnl"|"bkrnl")
			echo ">>> _td=\".bkrnl\"; _git_cloning;"
			_td=".bkrnl"; _git_cloning;
			;;
		".b_src.git"|".b_src"|"bsrc")
			echo ">>> _td=\".b_src\"; _git_cloning;";
			_td=".b_src"; _git_cloning;
			;;
		"all"|"ALL"|"All")
			echo ">>> _td=\".bd\"; _git_cloning;"
			_td=".bd"; _git_cloning;
			echo ">>> _td=\".blib\"; _git_cloning;"
			_td=".blib"; _git_cloning;
			echo ">>> _td=\".bkrnl\"; _git_cloning;"
			_td=".bkrnl"; _git_cloning;
			echo ">>> _td=\".b_src\"; _git_cloning;";
			_td=".b_src"; _git_cloning;
			;;
		"--help"|"-h")
			_print_help;
			exit 0;
			;;
		*)
			echo "Undefined Keywords -- Terminate This Program";
			exit 1;
			;;
	esac
else
	echo ">>> _td=\".bd\"; _git_cloning;"
	_td=".bd"; _git_cloning;
	echo ">>> _td=\".blib\"; _git_cloning;"
	_td=".blib"; _git_cloning;
	echo ">>> _td=\".bkrnl\"; _git_cloning;"
	_td=".bkrnl"; _git_cloning;
	echo ">>> _td=\".b_src\"; _git_cloning;";
	_td=".b_src"; _git_cloning;
fi




