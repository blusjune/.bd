#!/bin/sh
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140519_212633




##
## SHOULD define the following variables to execute this script
##
## _codename="cairo" _tracelog_root="/mnt/nfs_tracelog" _testcase="L3_C019" _BDX 
##

_tstamp=$(tstamp);
_errlog=".p7n.error.log";

if [ "X$_p7n_root_radix" = "X" ]; then
	_p7n_root_radix=".parthenon";
fi
_p7n_root="${HOME}/iowa/${_p7n_root_radix}";
#_p7n_root="${HOME}/iowa/.parthenon";
#_p7n_root="${HOME}/iowa/.p7n";
echo "#P7N>> set _p7n_root to '$_p7n_root'";

_p7n_iowa_tools_root_src=".parthenon.iowa.tools";
_p7n_iowa_root_src=".parthenon.iowa.root";
_p7n_iowa_mlt_result_src=".parthenon.iowa.mlt_result";
_p7n_season="2014s1";

_iowa_tools=".tools";
_iowa_tools_fullpath="${_p7n_root}/${_iowa_tools}";
_iowa_dirpkg_root="_dirpkg";

_iowa_dinit_cf=".dinit.cf";
_iowa_parthenon_cf=".parthenon.cf";
#_tracelog_root="/mnt/nfs_tracelog"; # to be configured by user
_tracelog="tracelog";
_tracelog_root_symlink_fullpath="${_p7n_root}/${_tracelog}";
_iowa_root_bdx=".bdx.0100.y.parthenon.exec_all_iowa.sh";

_file_dir_leaf="dir_leaf.txt";




## Essential parameters
if [ "X$_codename" = "X" ]; then
	read -p "#<< .parthenon codename (_codename) [almaden|berlin|cairo|...] ? " _codename;
	if [ "X$_codename" = "X" ]; then
		_errmsg="#P7N:ERROR>> _codename SHOULD be specified -- EXIT";
		echo $_errmsg; echo "$0 : $_errmsg" >> $_errlog; exit 1;
	fi
fi
if [ "X$_testcase" = "X" ]; then
	read -p "#<< testcase (_testcase) [L3_C019] ? " _testcase;
	if [ "X$_testcase" = "X" ]; then
		_errmsg="#P7N:ERROR>> _testcase SHOULD be specified -- EXIT";
		echo $_errmsg; echo "$0 : $_errmsg" >> $_errlog; exit 1;
	fi
fi

_HDR="P7N.${_codename}";
_iowa_root="${_p7n_root}/iowa.${_tstamp}.${_codename}.${_testcase}";

if [ ! -d "$_p7n_root" ]; then
	mkdir -p $_p7n_root;
	echo "#${_HDR}>> created $_p7n_root";
fi
if [ ! -d "$_iowa_tools_fullpath" ]; then
	cp -pr $_p7n_iowa_tools_root_src $_iowa_tools_fullpath;
	echo "#${_HDR}>> created $_iowa_tools_fullpath";
	(cd $_iowa_tools_fullpath;
	 	if [ ! -d $_iowa_dirpkg_root ]; then
			mkdir -p $_iowa_dirpkg_root
		fi
	)
	cp -pr $_p7n_iowa_mlt_result_src ${_iowa_tools_fullpath}/${_iowa_dirpkg_root};
	echo "#${_HDR}>> created $_p7n_iowa_mlt_result_src on ${_iowa_tools_fullpath}/${_iowa_dirpkg_root}";
fi




## The essential prerequisites
# check and setup tracelog symlink
if [ "X$_tracelog_root" = "X" ]; then
	read -p "#<< source directory for tracelog (_tracelog_root) [/mnt/nfs_tracelog] ? " _tracelog_root;
	if [ "X$_tracelog_root" = "X" ]; then
		_errmsg="#${_HDR}:ERROR>> _tracelog_root SHOULD be specified -- EXIT";
		echo $_errmsg; echo "$0 : $_errmsg" >> $_errlog; exit 1;
	fi
fi
if [ ! -d $_tracelog_root ]; then
	_errmsg="#${_HDR}:ERROR>> '$_tracelog_root' does not exist -- EXIT";
	echo $_errmsg; echo "$0 : $_errmsg" >> $_errlog; exit 1;
fi
if [ ! -d $_tracelog_root_symlink_fullpath ]; then
	(cd $_p7n_root;
		ln -s $_tracelog_root $_tracelog;
	)
fi




_install_01="_install__iowa_root";
_install_02="_install__iowa_mlt_result_inst_bdx__${_codename}";




_install__dinit_cf()
{
	cat > $_iowa_dinit_cf << EOF_DINIT_CF
#.dinit.cf
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=$_tstamp; 

_tracelog_root="${_tracelog}/_${_codename}";
_tgt_1="$_testcase";
_tgt_2s="m01-xfs m02-ext4 m03-f2fs";
#_tgt_21="m01-xfs";
#_tgt_22="m02-ext4";
#_tgt_23="m03-f2fs";
EOF_DINIT_CF
	echo "#${_HDR}>> created $_iowa_dinit_cf";
}


_install__iowa_root_bdx()
{
	# create root _BDX
	(cd $_p7n_root;
		echo "#!/bin/sh" > $_iowa_root_bdx;
		echo "#_ver=$_tstamp" >> $_iowa_root_bdx;
		_iowa_dir=$(ls -1d iowa.*);
		for _i in $_iowa_dir; do
			echo "(cd $_i; _BDX;)" >> $_iowa_root_bdx;
		done
	)
	echo "#${_HDR}>> created $_iowa_root_bdx";
}


_install__iowa_root()
{
	#cp -pr $_p7n_iowa_root_src $_iowa_root;
	mkdir -p $_iowa_root;
	echo "#${_HDR}>> created '$_iowa_root' directory";
	(cd $_iowa_tools_fullpath;
	 	_srclist=$(ls -1 .bdx.* .bpy.* .rlib.*);
		for _i in $_srclist; do
			(cd $_iowa_root;
			 	ln -s ../$_iowa_tools/$_i;
			)
		done
	 	(cd $_iowa_root;
			# _install__dinit_cf;
			cp ../$_iowa_tools/$_iowa_dinit_cf .;
			cp ../$_iowa_tools/$_iowa_parthenon_cf .;
		)
	)
	_install__iowa_root_bdx;
}


_install__iowa_mlt_result_inst_bdx__almaden()
{
	echo "#${_HDR}>> started";
	echo "#${_HDR}>> finished";
}


_install__iowa_mlt_result_inst_bdx__berlin()
{
	echo "#${_HDR}>> started";
	echo "#${_HDR}>> finished";
}


_install__iowa_mlt_result_inst_bdx__cairo()
{
	_bdx_0110=".bdx.0110.y.parthenon.${_codename}.${_p7n_season}.install_iowa_mlt_result.sh";
	(cd $_iowa_root;
		cat > $_bdx_0110 << EOF_IOWA_MLT_RESULT_BDX
#!/bin/sh
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=$_tstamp; 

_errlog=".p7n.error.log";
if [ ! -r $_file_dir_leaf ]; then
	_errmsg="#${_HDR}:ERROR>> '$_file_dir_leaf' does not exist. You SHOULD run first _BDX in $(pwd) -- EXIT";
	echo \$_errmsg; echo "\$0 : \$_errmsg" >> \$_errlog; exit 1;
fi
_list_dir=\$(cat $_file_dir_leaf);
for _i in \$_list_dir; do
	_install_target=\$(dirname \$(echo \$_i | sed -e 's/\(.*\)\/\$/\1/g'))
	echo "#${_HDR}>> created $_p7n_iowa_mlt_result_src on \$_install_target";
	cp -pr ../${_iowa_tools}/${_iowa_dirpkg_root}/${_p7n_iowa_mlt_result_src} \$_install_target;
done
EOF_IOWA_MLT_RESULT_BDX
		chmod 755 $_bdx_0110;
		echo "#${_HDR}>> created $_bdx_0110";
	)
}




$_install_01
#$_install_02 # no need to do this




