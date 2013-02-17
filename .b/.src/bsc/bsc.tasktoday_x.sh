#!/bin/sh
##
## bsc.tasktoday_x.sh
##
##tstamp: 20121106_213553
## tt.g: tasktoday grep
## tt.gln: tasktoday grep-ln (grep and then create link to the directory)

if [ $# -eq 0 ]; then
	_kw="";
else
	_kw="$1";
fi

_ttx_bn="$(basename $0)";
_b_tsk="${HOME}/x/tsk/";
_grep_maxdepth="4";




_ttx_g()
{
	if [ "X$_kw" = "X" ]; then
		find $_b_tsk -maxdepth ${_grep_maxdepth} -type d -name "t??.*" | sort;
	else
		find $_b_tsk -maxdepth ${_grep_maxdepth} -type d -name "t??.*" | grep -i $_kw | sort;
	fi
}




_ttx_gln()
{
	if [ "X$_kw" = "X" ]; then
		find $_b_tsk -maxdepth ${_grep_maxdepth} -type d -name "t??.*" | sort;
	else
		_num_of_dirs=$(find $_b_tsk -maxdepth ${_grep_maxdepth} -type d -name "t??.*" | grep -i $_kw | wc -l);
		if [ $_num_of_dirs -eq 1 ]; then
			_dir=$(find $_b_tsk -maxdepth ${_grep_maxdepth} -type d -name "t??.*" | grep -i $_kw);
			echo ">>> create a link to '$_dir'";
			ln -s $_dir;
		else
			echo ">>> cannot create link: $_num_of_dirs directories are matched";
			find $_b_tsk -maxdepth ${_grep_maxdepth} -type d -name "t??.*" | grep -i $_kw | sort;
			exit 1;
		fi
	fi
}




## main()
case $_ttx_bn in
	"ttx.g"|"ttg")
		_ttx_g;
		;;
	"ttx.gln"|"ttgln")
		_ttx_gln;
		;;
	*)
		echo "";
		echo "# Usage";
		echo "ttx.[g|gln] [<single_word_tag>]";
		echo "tt[g|gln] [<single_word_tag>]";
		echo "	ttx.g|ttg	: list or grep tasktoday directory";
		echo "	ttx.gln|ttgln	: create link to the specified tasktoday directory";
		echo "";
		;;
esac




