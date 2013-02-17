#!/bin/sh
## .bdx.0100.y.rename_with_sn.sh
##tstamp: 20121001_000254


#_prefix_default="prefix_foo";
_prefix_default="img";
#_suffix_default="suffix_bar";
_suffix_default="jpg";


if [ "X$BDX_FN_PREFIX" != "X" ]; then
	_prefix="$BDX_FN_PREFIX";
else
	_prefix="$_prefix_default";
fi
if [ "X$BDX_FN_SUFFIX" != "X" ]; then
	_suffix="$BDX_FN_SUFFIX";
else
	_suffix="$_suffix_default";
fi


_sn=0;


for _i in $(ls -1);
do
	_sn="$(echo $_sn + 1 | bc)";
	_fn_old="$_i";
	_fn_new="$(printf %s--%08d.%s ${_prefix} ${_sn} ${_suffix})";
	mv $_fn_old $_fn_new;
done


