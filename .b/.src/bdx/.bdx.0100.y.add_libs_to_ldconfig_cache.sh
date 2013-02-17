#!/bin/sh
##tstamp: 20121006_094417




_tstamp=$(tstamp);
_target_lib_list_file=".target_lib_list_file";

_cmd_prefix_symlink="ln -s";
_cmd_prefix_copy="cp -p";

_cmd_suffix_symlink="";
_cmd_suffix_copy=".";




echo "BDX> This bdx command may be used for /x/sys/lib or /x/sys/local/lib directories";
echo "BDX> 'LD_LIBRARY_PATH' should contain /x/sys/lib or /x/sys/local/lib directories";

read -p "BDX> Choose operation type to execute: ['copy'|'link'] " _ans;
case $_ans in
	"copy")
		_cmd_prefix=$_cmd_prefix_copy;
		_cmd_suffix=$_cmd_suffix_copy;
		;;
	"link")
		_cmd_prefix=$_cmd_prefix_symlink;
		_cmd_suffix=$_cmd_suffix_symlink;
		;;
	*)
		echo ">>> invalid operation -- exit this program";
		exit 1;
		;;
esac




cat > $_target_lib_list_file << EOF

/usr/lib/tcltk/mysqltcl-3.05/libmysqltcl3.05.so

EOF




_lib_list=`cat $_target_lib_list_file`
for _i in $_lib_list; do
	echo "($_cmd_prefix $_i $_cmd_suffix)";
	$_cmd_prefix $_i $_cmd_suffix;
done




sudo ldconfig;
ldconfig -p > /tmp/.ldconfig_print_cache-$_tstamp;
ln -s /tmp/.ldconfig_print_cache-$_tstamp;
exit 0;







## ver 2.0
/usr/lib/tcltk/mysqltcl-3.05/libmysqltcl3.05.so
/usr/lib/x86_64-linux-gnu/libmysqlclient.so.18
/usr/lib/x86_64-linux-gnu/libmysqlclient_r.so.18


## ver 1.0
/usr/lib/tcltk/mysqltcl-3.05/libmysqltcl3.05.so
/usr/lib/x86_64-linux-gnu/libmysqlclient.so.18
/usr/lib/x86_64-linux-gnu/libmysqlclient.so.18.0.0
/usr/lib/x86_64-linux-gnu/libmysqlclient_r.so.18
/usr/lib/x86_64-linux-gnu/libmysqlclient_r.so.18.0.0

