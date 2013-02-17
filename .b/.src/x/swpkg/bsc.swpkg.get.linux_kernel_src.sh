#!/bin/sh
## 20120823_000247


_prog_name="$(basename $0)";


print_help()
{
	echo "usage:";
	echo "	$_prog_name <kernel_version>";
	echo "	e.g., $_prog_name 3.2.1";
}


if [ $# -eq 1 ]; then
	case $1 in
		"-h"|"--help"|"-help")
			print_help;
			exit 0;
			;;
		*)
			_k_ver="$1";
			;;
	esac
else
	print_help;
	exit 0;
fi


_kv_a=$(echo $_k_ver | sed -e 's/\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)/\1/g');
_kv_b=$(echo $_k_ver | sed -e 's/\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)/\2/g');
_kv_c=$(echo $_k_ver | sed -e 's/\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)/\3/g');


## as of 20120824_002719,
## Linux kernel source tar-ball directory path is not organized elegantly
## : there is no directory 'v3.1' or 'v3.2' and so on.
## : only 'v3.0' or 'v3.x' directory exists.

#_version_dir="v${_kv_a}.${_kv_b}";
case $_kv_a in
	"3")
		_version_dir="v${_kv_a}.0";		# it means "v3.0"
		;;
	*)
		_version_dir="v${_kv_a}.${_kv_b}";	# general form
		;;
esac


_k_url="www.kernel.org/pub/linux/kernel/$_version_dir/linux-${_k_ver}.tar.bz2";
echo "### wget $_k_url";
wget $_k_url;
