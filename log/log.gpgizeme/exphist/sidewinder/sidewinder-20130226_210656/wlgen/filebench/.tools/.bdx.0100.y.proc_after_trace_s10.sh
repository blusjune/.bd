#!/bin/sh
#.bdx.0100.y.proc_after_trace_s10.sh
#_ver=20130226_203746
#_ver=20130226_204357




_proc_01()
{
#	_target # parameter: target name (dir)
	_bpo_a="bpo_a.${_target}.log";
	cat $_target/*.blktrace.* | blkparse -i - > $_bpo_a
}


_proc_02()
{
#	_target # parameter: target name
	_bpo_a="bpo_a.${_target}.log";
	_bpo_b="bpo_b.${_target}.log";
	cat -n $_bpo_a | tail -200 | more;
	read -p "#<< boundary line number: " _lnum;
	if [ "X$_lnum" = "X" ]; then
		echo "#>> Aborted -- EXIT";
		exit 1;
	else
		cat $_bpo_a | head -${_lnum} > $_bpo_b
	fi
}


_total=`ls -1d tid.*.* | wc -l`
_count=0;
for _target in `ls -1d tid.*.*`; do
	_count=$(expr $_count + 1);
	echo "proc_01[$_count/$_total]: '$_target'";
	sleep 2;
	_proc_01;
done
_count=0;
for _target in `ls -1d tid.*.*`; do
	_count=$(expr $_count + 1);
	echo "proc_02[$_count/$_total]: '$_target'";
	sleep 2;
	_proc_02;
done


exit 0


_target="20130226_131303.fileserver"; _proc_01;
_target="20130226_141319.networkfs"; _proc_01;
_target="20130226_151342.varmail"; _proc_01;
_target="20130226_161347.videoserver"; _proc_01;
_target="20130226_171522.webserver"; _proc_01;


_target="20130226_131303.fileserver"; _proc_02;
_target="20130226_141319.networkfs"; _proc_02;
_target="20130226_151342.varmail"; _proc_02;
_target="20130226_161347.videoserver"; _proc_02;
_target="20130226_171522.webserver"; _proc_02;
