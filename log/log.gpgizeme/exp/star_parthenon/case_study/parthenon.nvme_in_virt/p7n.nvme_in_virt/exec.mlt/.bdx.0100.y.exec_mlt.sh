#!/bin/sh
_ver=20140710_222537




_mlt_cmd="mlt.run_trace-v2";
_mlt_d="mlt.d-20140702_132822";
_mlt_test_cnf="/tmp/test.cnf";
_mlt_cnf="${_mlt_d}/conf/mlt.cnf";




if [ "X$(id -u)" != "X0" ]; then
	echo "#ERROR>> you SHOULD have root privilege to run this program -- EXIT";
	exit 1;
fi




	echo "
--------------------------------";
cat $_mlt_cnf;
echo "--------------------------------
";
read -p "#<< is this good for your test? [Y|n] " _ans;
if [ "X$_ans" = "Xn" ]; then
	echo "#>> edit '$_mlt_cnf' and then come back please -- EXIT";
	exit 0;
fi




if [ -f $_mlt_test_cnf ]; then
	echo "
--------------------------------";
	cat $_mlt_test_cnf;
	echo "--------------------------------
";

#	_tstamp=$(head -1 $_mlt_test_cnf | awk '{ print $2 }');
#	echo "_tstamp: ($_tstamp)";

	read -p "#<< start MLT with this test.cnf file? [Y|n] " _ans;
	if [ "X$_ans" = "Xn" ]; then
		echo "#>> Terminate this program -- EXIT";
		exit 0;
	fi

	cp $_mlt_test_cnf ${_mlt_d}/conf;
	(cd $_mlt_d; ./${_mlt_cmd};)
else
	echo "#ERROR>> could not find '$_mlt_test_cnf' -- EXIT";
	exit 1;
fi




