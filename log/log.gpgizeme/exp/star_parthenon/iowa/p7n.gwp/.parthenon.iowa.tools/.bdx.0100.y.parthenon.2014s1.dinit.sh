#!/bin/sh




_this_program="parthenon.2014s1.dinit";




_tstamp=$(tstamp);
_errlog=".bdx.error.log";

_datainit_cf=".dinit.cf";
#_tracelog_root="tracelog";
#_tgt_1="L3_C019";
#_tgt_2s="m01-xfs m02-ext4 m03-f2fs";
##_tgt_21="m01-xfs";
##_tgt_22="m02-ext4";
##_tgt_23="m03-f2fs";
if [ -f $_datainit_cf ]; then
	. $_datainit_cf;
else
	_errmsg="#BDX:ERROR>> $_datainit_cf does not exist -- EXIT";
	echo $_errmsg; echo "$_this_program : $_errmsg" >> $_errlog; exit 1;
fi




# ASSERT: _tgt_2s SHOULD NOT be empty
if [ "X$_tgt_2s" = "X" ]; then
	_errmsg="#BDX:ERROR>> $_tgt_2s does not exist -- EXIT";
	echo $_errmsg; echo "$_this_program : $_errmsg" >> $_errlog; exit 1;
fi
for _i in $_tgt_2s; do
	_trlogd_dep1=$_i; #_tgt_2s="m01-xfs m02-ext4 m03-f2fs";
done
_tarfile_last=$(ls -1 ../$_tracelog_root/$_trlogd_dep1 | grep $_tgt_1 | tail -1);
_num_of_testcases=$(echo $_tarfile_last | awk -F'_' '{ print $6 }');




#_unzipcat="cat ";
#_unzipcat="bunzip2 -c ";
_unzipcat="gunzip -c ";




#
# DNRF: Directory Name Record File
#

_dnrf__leaf="$(pwd)/dnrf.leaf.txt";
_f_mlt_record_cwd_leaf()
{
	_tgt_dir=$(ls -1F | grep '^mlt' | grep '/' | head -1);
	(cd $_tgt_dir; pwd >> $_dnrf__leaf);
}

_dnrf__tpcc="$(pwd)/dnrf.tpcc.txt";
_f_mlt_record_cwd_tpcc()
{
	pwd >> $_dnrf__tpcc;
}




_tpcc_result_log="tpcc_result.log";
_count=0;
while [ $_count -lt $_num_of_testcases ]; do
	_count=$(expr $_count + 1);
	_stmt_radix="${_count}_of_${_num_of_testcases}";
	_dir_radix="${_tgt_1}_${_stmt_radix}";

#	_stmt_m="m_${_stmt_radix}"; # m_1_of_5
#	_stmt_s="s_${_stmt_radix}"; # s_1_of_5
#	_prefix_m="${_tgt_1}${_stmt_m}"; # L3_C019m_1_of_5
#	_prefix_s="${_tgt_1}${_stmt_s}"; # L3_C019s_1_of_5

	if [ ! -d $_dir_radix ]; then
		echo "mkdir $_dir_radix";
		mkdir $_dir_radix;
	fi
	(cd $_dir_radix;

		for _i in $_tgt_2s; do
			_tgt_2x=$_i; #_tgt_2s="m01-xfs m02-ext4 m03-f2fs" OR _tgt_2s="m01-dcs3500 m02-pm853t"
		 	if [ ! -d $_tgt_2x ]; then
		 		echo "	mkdir $_tgt_2x";
		 		mkdir $_tgt_2x;
			fi
			(cd $_tgt_2x; _f_mlt_record_cwd_tpcc;
			 	_files=$(ls -1 ../../../$_tracelog_root/$_tgt_2x | grep $_tgt_1 | grep $_stmt_radix);
				if [ "X$_files" = "X" ]; then
					_errmsg="#BDX:ERROR>> cannot find any files matched with $_tgt_1 and $_stmt_radix -- EXIT";
					echo $_errmsg; echo "$_this_program : $_errmsg" >> $_errlog; exit 1;
				fi
				for _file in $_files; do
					_tag=$(echo $_file | awk -F'_' '{ print $3 }'); # 'm' or 's'
					_result_dir="result-$_tag";
					#_stmt_tag="${_tag}_${_stmt_radix}"; # 'm_1_of_5' or 's_1_of_5'
					#_prefix_tag="${_tgt_1}_${_stmt_tag}"; # L3_C019_m_1_of_5

					if [ ! -d $_result_dir ]; then
						echo "		$(..ts)  --  extracting  $_file  ($_tgt_2x)";
						$_unzipcat ../../../$_tracelog_root/$_tgt_2x/$_file | tar xf -
						if [ ! -d $_result_dir ]; then
							mv result $_result_dir;
						fi
					else
						echo "		$(..ts)  --  no need to extract  $_file  ($_tgt_2x)  ..  skipped";
					fi

					(cd $_result_dir; _f_mlt_record_cwd_leaf);

					## post processing for TPC-C
					_tpcc_result_file="";
					if [ -d $_result_dir ]; then
						(cd $_result_dir;
						 	_tpcc_result_file=$(ls -1 | grep tpcc | tail -1);
							if [ "X$_tpcc_result_file" != "X" ]; then
								echo "		$_tpcc_result_file is found";
								(cd ..; ln -s ${_result_dir}/$_tpcc_result_file $_tpcc_result_log)
							else
								echo "		ERROR: tpcc result file '$_tpcc_result_file' is not found -- EXIT";
								exit 1;
							fi
						)
					fi
				done

			)
		done

	)
done




