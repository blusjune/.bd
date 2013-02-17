#!/bin/sh

##bsc.iowa.extract_rawdata_from_blkparse_logfile.sh
##tstamp: 20121119_230359




_this_prog=$(basename $0);
. ..bhdr; echo "$_BHDR $_this_prog";
_print_help()
{
	echo "#>> blkparse output log file name should be specified";
}
_cmd__print_seekdist=".tmp.print_seekdist.py";

cat > $_cmd__print_seekdist << EOF
#!/usr/bin/python
##-------------------------------------------
import os;
_infile = os.environ['_INFILE'];
f = open(_infile, 'r');
_addr_prev = 0;
_seek_dist = 0;
for line in f:
#	_addr_curr = int(line.split()[10]);
	_addr_curr = int(line.split()[0]);
	_seek_dist = _addr_curr - _addr_prev;
	_addr_prev = _addr_curr;
	print _seek_dist;
f.close()
##-------------------------------------------
EOF
chmod 755 $_cmd__print_seekdist




if [ "X$1" != "X" ]; then
	if [ "X$1" = "X-h" -o "X$1" = "X--help" ]; then
		_print_help;
		exit 0;
	else
		_if=$1;
	fi
else
	if [ "X$_if" = "X" ]; then
		read -p "#?? input file (blkparse output): " _if;
	fi
fi
echo "#>> extracting raw data from '$_if' for further processing ...";




_of_1="$_if.1.preproc.out";
_of_A_addr="$_if.A.addr"; ## All (read + write)
_of_A_seek="$_if.A.seek"; ## All (read + write)
_of_R_addr="$_if.R.addr"; ## Read
_of_R_seek="$_if.R.seek"; ## Read
_of_W_addr="$_if.W.addr"; ## Write
_of_W_seek="$_if.W.seek"; ## Write


echo "#>> generating '$_of_1' ...";
cat $_if | awk '{ print "_" $7, "__" $6, "___" $1, $0 }' | grep -e '_[RW]' | grep '__Q' > $_of_1;	## Q phase
#cat $_if | awk '{ print "_" $7, "__" $6, "___" $1, $0 }' | grep -e '_[RW]' | grep '__D' > $_of_1;	## D phase


echo "#>> generating '$_of_A_addr' ...";
cat $_of_1 | awk '{ print $11 }' > $_of_A_addr;
echo "#>> generating '$_of_A_seek' ...";
_INFILE="$_of_A_addr" python $_cmd__print_seekdist > $_of_A_seek;


echo "#>> generating '$_of_R_addr' ...";
cat $_of_1 | grep -e '_R' | awk '{ print $11 }' > $_of_R_addr;
echo "#>> generating '$_of_R_seek' ...";
_INFILE="$_of_R_addr" python $_cmd__print_seekdist > $_of_R_seek;


echo "#>> generating '$_of_W_addr' ...";
cat $_of_1 | grep -e '_W' | awk '{ print $11 }' > $_of_W_addr;
echo "#>> generating '$_of_W_seek' ...";
_INFILE="$_of_W_addr" python $_cmd__print_seekdist > $_of_W_seek;




