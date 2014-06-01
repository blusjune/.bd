#!/bin/sh
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140520_180442; 

_errlog=".p7n.error.log";

_dnrf__leaf="dnrf.leaf.txt";
_dnrf__p7n_work="dnrf.p7n_work.txt";
_p7n_iowa_mlt_result_dir=".parthenon.iowa.mlt_result";
_p7n_work_dir=".work.p7n";

if [ ! -r $_dnrf__leaf ]; then
	_errmsg="#P7N.cairo:ERROR>> '$_dnrf__leaf' does not exist. You SHOULD run first _BDX in the directory $(pwd) -- EXIT";
	echo $_errmsg; echo "$0 : $_errmsg" >> $_errlog; exit 1;
fi
_list_dir=$(cat $_dnrf__leaf);
for _i in $_list_dir; do
	_install_target=$(dirname $(echo $_i | sed -e 's/\(.*\)\/$/\1/g'))
	echo "#P7N.cairo>> created .parthenon.iowa.mlt_result on $_install_target";
	cp -pr ../.tools/_dirpkg/.parthenon.iowa.mlt_result $_install_target;
	(cd ${_install_target}/${_p7n_iowa_mlt_result_dir}; _BDX;)
	echo $(cd ${_install_target}/${_p7n_work_dir}; pwd) >> $_dnrf__p7n_work;
done
