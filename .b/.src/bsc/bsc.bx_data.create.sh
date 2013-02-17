#!/bin/sh

## bsc.bx_data.create.sh


LANG=C export LANG;


_this_prog=$(basename $0);
_bxd_basename="bx_data";
_bxd_prefix_default="${HOME}";


#echo "\$# ($#)"

if [ $# -eq 0 ]; then
	echo "[usage] $_this_prog <prefix to the 'bx_data' directory>";
	exit 0;
fi
if [ $# -eq 1 ]; then
	_bxd_prefix="$1";
else
	echo ">>> ERROR: only one parameter is allowed";
	echo ">>> Terminate this program";
	exit 1;
fi

_bxd_root="${_bxd_prefix}/${_bxd_basename}";

if [ -d ${_bxd_root} ]; then
	echo ">>> ERROR: ${_bxd_root} directory already exists!";
	echo ">>> Terminate this program";
	exit 2;
fi

mkdir -p ${_bxd_root};
cd ${_bxd_root};

_bxd_subdir="bin etc lib mnt prj tsk var t";
mkdir ${_bxd_subdir};
mkdir x; # 'x' is special purpose directory
cd x;
for _i in ${_bxd_subdir}; do
	ln -s ../${_i};
done
cd ..; # current directory should be ${_bxd_root}
chmod 777 t x; # chmod 777 for special directories

echo ">>> '${_bxd_root}' is created successfully";
