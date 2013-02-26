#!/bin/sh

##bsc.iowa.mk_hitfreq_dist_table.sh
##tstamp: 20121114_202433
##tstamp: 20121119_230342
##tstamp: 20121121_191729




_this_prog=$(basename $0);
. ..bhdr; echo "$_BHDR $_this_prog";
_cal_hitfreq="cal_hitfreq_from_infile.py";
_cal_hitfreq_infile_default="infile";
_f_p10="anal.p10.hitfreq_per_item.txt";
_f_p11="anal.p11.hitfreq_per_item_sorted_by_hitfreq.csv";
_f_p20="anal.p20.hitfreq_dist.txt";
_f_p30="anal.p30.num_of_item_per_hitfreq.csv";
_print_help()
{
	echo "#>> $_this_prog";
	echo "#>> $_this_prog <some_file_name>";
	echo "#>> _infile=<some_file_name> $_this_prog";
}




if [ ! -f $_cal_hitfreq ]; then
	cat > $_cal_hitfreq << EOF
#!/usr/bin/python
##bsc.iowa.cal_hitfreq_from_infile.py
##tstamp: 20121114_150933


## set all the counters to zero
#lines, blanklines, sentences, words = 0, 0, 0, 0
lines = 0


##
from collections import defaultdict
from string import punctuation

words = defaultdict(int)

#print '-' * 50


try:
	fn_i='infile'
	textf = open(fn_i, 'r')
except IOError:
	print 'CANNOT open file "%s" for reading' % fn_i
	import sys
	sys.exit(0)


## reads one line at a time
for line in textf:
#	print line, # test
#	words[line.strip(punctuation)] += 1	# it causes unexpected result
	words[line] += 1
	lines += 1


for word, freq in words.items():
	print word.strip() + " : " + str(freq)

#print '-' * 50
#print 'Total lines of data: %d' % lines
EOF
	chmod 755 $_cal_hitfreq;
fi




if [ -f $_cal_hitfreq_infile_default ]; then
	echo "#>> now removing old $_cal_hitfreq_infile_default link";
	rm $_cal_hitfreq_infile_default;
fi




if [ "X$1" != "X" ]; then
	if [ "X$1" = "X-h" -o "X$1" = "X--help" ]; then
		_print_help;
		exit 0;
	else
		_infile=$1;
	fi
else
	if [ "X$_infile" = "X" ]; then
		read -p "#?? input file name (lines of items, one item per each line): " _infile;
	fi
fi
_cal_hitfreq_infile=$_infile;
echo "#>> processing '$_cal_hitfreq_infile' (as 'infile') ...";




if [ -f $_cal_hitfreq_infile ]; then
	ln -s $_cal_hitfreq_infile $_cal_hitfreq_infile_default;
else
	echo "#>> ERROR: $_cal_hitfreq_infile file does not exist";
	exit 1;
fi
_total_num_of_hits=$(cat $_cal_hitfreq_infile | wc -l);




## processing 10
if [ -f $_cal_hitfreq ]; then
	python $_cal_hitfreq > $_f_p10;
	echo "hit_count , seek_dist" > $_f_p11;
	cat $_f_p10 | awk '{ print $3, ",", $1 }' | sort -n >> $_f_p11;
else
	echo "#>> ERROR: $_cal_hitfreq file does not exist";
	exit 1;
fi




## processing 20
cat $_f_p10 | awk '{ print $3 }' | sort -nu > $_f_p20;




## processing 30
_acc_num_of_hits=0;
echo "hit_count , number_of_related_items" >> $_f_p30;
for _i in $(cat $_f_p20); do
	_noi_per_hitfreq=$(grep -e ": \<$_i\>" $_f_p10 | wc -l);
	echo "$_i , $_noi_per_hitfreq" >> $_f_p30;
	_num_of_hits=$(echo "$_i * $_noi_per_hitfreq" | bc);
	_acc_num_of_hits=$(echo "$_acc_num_of_hits + $_num_of_hits" | bc);
done

if [ $_total_num_of_hits -eq $_acc_num_of_hits ]; then
	exit 0;
else
	echo "#>> ERROR: Something wrong!!! ";
	echo "#>> total number of hits (extracted from original source) : $_total_num_of_hits";
	echo "#>> calculated sum of product (hit freq, # of hits)       : $_acc_num_of_hits";
	exit 1;
fi




