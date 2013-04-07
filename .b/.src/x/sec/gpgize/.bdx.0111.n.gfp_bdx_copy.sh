#!/bin/sh
##.bdx.0111.n.gfp_bdx_copy.sh
##_ver=20121219_234356


echo "#>> copy .bdx to .b/.src/bdx";
_tstamp="$(tstamp)";


_backup_dir="sys/_/backup";
_bdxold_dir=".oldbdx.${_tstamp}";
_bdxold_tgz="$_bdxold_dir.oldtgz";
## .gitignore file should contain the following line:
## *.oldtgz


if [ ! -d .bdx ]; then
	echo "#>> ERROR: .bdx/ directory is not found -- EXIT";
	exit 1;
fi


if [ ! -d $_backup_dir ]; then
	mkdir -p $_backup_dir;
fi
if [ -d ~/.b/.src/bdx ]; then
	(cd $_backup_dir;
	mv ~/.b/.src/bdx ${_bdxold_dir};
	tar cf - $_bdxold_dir | gzip -c > $_bdxold_tgz;
	rm -fr $_bdxold_dir;
	)
fi


sleep 1; _tstamp="$(tstamp)";
rm .bdx/..__bdx__*;
touch .bdx/..__bdx__.$_tstamp;
cp -pr .bdx ~/.b/.src/bdx;


bpk.pack;


