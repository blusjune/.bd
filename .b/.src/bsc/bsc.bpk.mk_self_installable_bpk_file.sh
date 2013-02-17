#!/bin/sh

##
##
## Thu Apr  5 01:31:00 KST 2012


_prog_name="$(basename $0)";
_timestamp="$(date +%Y%m%d_%H%M%S)";
_b=".b";

if [ $# -eq 1 ]; then
	if [ "X$1" = "X-h" -o "X$1" = "X--help" ]; then
		echo "[usage] $_prog_name <GnuPG armored BPK file '.asc'>";
		exit 0;
	else
		_fi="$1";
		_fi_suffix="$(echo $_fi | sed -e 's/.*\.\(.*\)/\1/g')";
		if [ "X$_fi_suffix" != "Xasc" ]; then
			echo "> ERROR: wrong file suffix (should be a GnuPG '.asc' file)";
			exit 1;
		fi
		_fi_head="$(echo $_fi | sed -e 's/\(bpk\)-.*/\1/g')";
		if [ "X$_fi_head" != "Xbpk" ]; then
			echo "> ERROR: wrong file header (should be a canonical BPK file)";
			exit 2;
		fi
	fi
else
	echo "[usage] $_prog_name <GnuPG armored BPK file '.asc'>";
	exit 0;
fi

_fo="${_fi}.sh";
_b_dirname="$(echo $_fi | sed -e 's/\(bpk-[0-9]*_[0-9]*\)\.\(.*\)\.asc/\1/g')";
_b_gztar_ball="${_b_dirname}.tgz";
_tmpd_base=".bpk_td#$_b_dirname#$_timestamp";




cat > $_fo << BEEE_EOF_01
#!/bin/sh

echo "";
echo "> BPK install:   started";
echo "> ----------------------";

_tstamp="\$(date +%Y%m%d_%H%M%S)";
_tmpd="$_tmpd_base#\$_tstamp";
mkdir \$_tmpd;
cd \$_tmpd;
cat > $_fi << BEEE_EOF_02
BEEE_EOF_01

cat $_fi >> $_fo;

cat >> $_fo << BEEE_EOF_03
BEEE_EOF_02

read -p "> key: " _b_pw;
echo \$_b_pw | gpg --passphrase-fd 0 -o $_b_gztar_ball $_fi;
gunzip -c $_b_gztar_ball | tar xf -;
(
	cd \$HOME;
	if [ -d $_b ]; then
		if [ ! -d .bold ]; then
			mkdir .bold;
		fi
		mv $_b .bold/.bold.\$_tstamp;
	fi
)
mv $_b_dirname \$HOME/$_b;
cd ..;

echo "> $_b directory is located at \$HOME/$_b :";
ls -alF \$HOME/$_b;

echo "> ----------------------";
echo "> BPK install: completed";
echo "";

BEEE_EOF_03

chmod 755 $_fo;




