#!/bin/sh
##.bdx.0100.y.srcmgmt_create_code_nav_index.sh
##_ver=20121213_151247
##_ver=20121214_193109
##_ver=20121219_200030




_tstamp=$(tstamp);
_osname="$(uname -s | tr '[:upper:]' '[:lower:]')"; ## should be "linux";
_conf_set()
{
	echo "#>> manual configuration";
	read -p "#<< target source directory: " _srcdir;
}




_srcdir="$_osname";
_dircount=$(ls -1F | grep '/'| wc -l);
_srcdir_radix="";
if [ $_dircount -gt 0 ]; then
	_srcdir_radix=$(ls -1F | grep '/' | tail -1 | sed -e 's/\([^-]*\)-.*/\1/g');
	_srcdir_fullname=$(ls -1F | grep '/' | tail -1 | sed -e 's/\([^\/]*\)\//\1/g');
fi
#echo "#>> _srcdir_radix    : ($_srcdir_radix)";
#echo "#>> _srcdir_fullname : ($_srcdir_fullname)";


_srcdir=$_srcdir_fullname;
echo "#>> target source directory: '$_srcdir'";
read -p "#<< proceed with this automatic conf? ['y'|n] " _ans;
if [ "X$_ans" = "Xn" ]; then
	_conf_set;
	if [ "X$_srcdir" = "X" ]; then
		echo "#>> ERROR: target source directory SHOULD be specified -- EXIT";
		exit 0;
	else
		echo "#>> target source directory: '$_srcdir'";
		read -p "#<< proceed with this manual conf? ['y'|n] " _ans;
		if [ "X$_ans" = "Xn" ]; then
			exit 0;
		fi
	fi
fi


_index_file_ctags="${_srcdir}.tags";
_index_file_cscope="${_srcdir}.cscope_out";
_index_file_ctags_default="tags";
_index_file_cscope_default="cscope.out";



echo "#>> OK, now we are creating '$_index_file_ctags' and '$_index_file_cscope'";
if [ -f $_index_file_ctags ]; then
	mv $_index_file_ctags old.${_index_file_ctags}.$_tstamp;
fi
ctags -f $_index_file_ctags -R $_srcdir;
if [ -f $_index_file_ctags_default ]; then
	rm $_index_file_ctags_default;
fi
ln -s $_index_file_ctags $_index_file_ctags_default;


if [ -f $_index_file_cscope ]; then
	mv $_index_file_cscope old.${_index_file_cscope}.$_tstamp;
fi
cscope -f $_index_file_cscope -R -s $_srcdir;
if [ -f $_index_file_cscope_default ]; then
	rm $_index_file_cscope_default;
fi
ln -s $_index_file_cscope $_index_file_cscope_default;


echo "#>> Done! successfully";


