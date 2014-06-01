#!/bin/sh
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140509_165139;
#_ver=20140512_230449;
#_ver=20140519_211144;
#_ver=20140520_164906;




_errlog=".p7n.error.log";
_datafile="mlt.L3_db_01_oflm.tlog";

_tmp1=$(cat mlt.L3_db_01_oflm.tlog | awk '{ print $1 }'| grep 'data\/ibdata1' | sed -e 's/\(.*\)\/data\/ibdata1/\1/g' | sort -u);
if [ "X$_tmp1" = "X" ]; then
	_errmsg="#P7N:ERROR>> could not extract mysql data path -- EXIT";
	echo $_errmsg; echo "$0 : $_errmsg" >> $_errlog; exit 1;
fi
if [ "X$(echo $_tmp1 | wc -w)" != "X1" ]; then
	_errmsg="#P7N:ERROR>> abnormal case detected regarding mysql data path -- EXIT";
	echo $_errmsg; echo "$0 : $_errmsg" >> $_errlog; exit 1;
fi
_mysql_prefix=$_tmp1;                   # dynamic configuration
#_mysql_prefix="/var/lib/mysql/";       # static configuration
#_mysql_prefix="/mnt/sdd1/mysql.data/"; # static configuration

_mysql_prefix_to_be_cropped=$(echo $_mysql_prefix | sed -e 's/\//\\\//g')

_ofile_1_items=".tmp.1.items_list.txt";
_ofile_2_datafile_crop=".tmp.2.mlt.L3_db_01_oflm.tlog.crop";
_ofile_3_items_to_cmp=".tmp.3.items_to_cmp.txt";
_ofile_4_data_before=".tmp.4.data_1_before.txt";
_ofile_4_data_after=".tmp.4.data_2_after.txt";
_ofile_4_data_diff=".tmp.4.data_3_diff.txt";
_ofile_5_cmp_reduced=".tmp.5.items_to_cmp_reduced.txt";

_wcmd_01=".bpy.iowa.2014s1.mlt_L3_db_01.print_diff_data.py";
_wcmd_02=".rcmd.iowa.2014s1.mlt_L3_db_01.asys_010.r";




rm -f .tmp.*
rm -f img.*.png
#rm -f $_ofile_4_data_diff $_ofile_4_data_before $_ofile_4_data_after




#cat $_datafile | awk '{ print $1 }' | sort | uniq -c | sort | awk '{ if ($1 == '2') { print $2 } }' | grep $_mysql_prefix | sed -e 's/\/var\/lib\/mysql\///g' > $_ofile_1_items;
cat $_datafile | awk '{ print $1 }' | sort | uniq -c | sort | awk '{ if ($1 == "2") { print $2 } }' | grep $_mysql_prefix | sed -e "s/$_mysql_prefix_to_be_cropped//g" > $_ofile_1_items;
_items_list="$(cat $_ofile_1_items)";




#cat $_datafile | sed -e 's/\/var\/lib\/mysql\///g' > ${_ofile_2_datafile_crop};
cat $_datafile | sed -e "s/$_mysql_prefix_to_be_cropped//g" > ${_ofile_2_datafile_crop};


for _i in $_items_list; do
	echo "-----# $_i #-----";
	grep $_i $_ofile_2_datafile_crop >> $_ofile_3_items_to_cmp
done


cat $_ofile_3_items_to_cmp | $_wcmd_01 print_diff_data | grep -v '0 0 0 0 0 0 0 0 0 0 0 0 0' > $_ofile_4_data_diff
if [ "X$(cat $_ofile_4_data_diff | wc -l)" == "X0" ]; then
	echo "#P7N:WARNING>> No difference between 'before' and 'after' status - We will not create 'diff' result";
	cat $_ofile_3_items_to_cmp | $_wcmd_01 print_before_data | grep -v '0 0 0 0 0 0 0 0 0 0 0 0 0' > $_ofile_4_data_before
	cat $_ofile_3_items_to_cmp | $_wcmd_01 print_after_data | grep -v '0 0 0 0 0 0 0 0 0 0 0 0 0' > $_ofile_4_data_after
	_DATAFILE_IN=$_ofile_4_data_before export _DATAFILE_IN; echo -n "#P7N>> processing $_DATAFILE_IN ... "; R --silent -f $_wcmd_02 2>&1 > /dev/null; echo "completed";
	_DATAFILE_IN=$_ofile_4_data_after export _DATAFILE_IN; echo -n "#P7N>> processing $_DATAFILE_IN ... "; R --silent -f $_wcmd_02 2>&1 > /dev/null; echo "completed";
else
	_items_important_list=$(cat $_ofile_4_data_diff | awk '{ print $1 }')
	for _i in $_items_important_list; do
		grep $_i $_ofile_2_datafile_crop >> $_ofile_5_cmp_reduced;
	done
	cat $_ofile_5_cmp_reduced | $_wcmd_01 print_before_data | grep -v '0 0 0 0 0 0 0 0 0 0 0 0 0' > $_ofile_4_data_before
	cat $_ofile_5_cmp_reduced | $_wcmd_01 print_after_data | grep -v '0 0 0 0 0 0 0 0 0 0 0 0 0' > $_ofile_4_data_after
	_DATAFILE_IN=$_ofile_4_data_diff export _DATAFILE_IN; echo -n "#P7N>> processing $_DATAFILE_IN ... "; R --silent -f $_wcmd_02 2>&1 > /dev/null; echo "completed";
	_DATAFILE_IN=$_ofile_4_data_before export _DATAFILE_IN; echo -n "#P7N>> processing $_DATAFILE_IN ... "; R --silent -f $_wcmd_02 2>&1 > /dev/null; echo "completed";
	_DATAFILE_IN=$_ofile_4_data_after export _DATAFILE_IN; echo -n "#P7N>> processing $_DATAFILE_IN ... "; R --silent -f $_wcmd_02 2>&1 > /dev/null; echo "completed";
fi




