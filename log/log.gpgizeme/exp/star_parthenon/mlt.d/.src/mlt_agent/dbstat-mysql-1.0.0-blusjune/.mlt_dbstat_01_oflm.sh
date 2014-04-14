#!/bin/bash
#_ver=20140408_170831
#_ver=20140409_074228




_num_param=5;
if [ $# != $_num_param ]; then
	echo "#>> ERROR: check the number of parameters (should be $_num_param) -- EXIT";
	exit 1;
else
	_mlt_La_measure_duration_in_sec=$1
	_mlt_L3_measure_interval_in_sec=$2
	_mlt_L3_db_root_pw=$3;
	_mlt_L3T1_order_by=$4;
	_mlt_L3T1_limit_count=$5;
fi




# oflm: offline metric
# onlm: online metric




_sqlstmt__get__oflm__perfile_io_summary="
SELECT UNIX_TIMESTAMP() as 'Tstamp_a', DATE_FORMAT(CURTIME(), '%Y%m%d_%H%i%S') as 'Tstamp_b'\G;
USE performance_schema;
SELECT file_name as perfile_io_summary_fname,
	count_star as a_count,
	count_read as r_count,
	count_write as w_count,
	sum_number_of_bytes_read as r_bytes,
	sum_number_of_bytes_write as w_bytes,
	sum_timer_read as r_wait_sum, avg_timer_read as r_wait_avg, max_timer_read as r_wait_max, min_timer_read as r_wait_min,
	sum_timer_write as w_wait_sum, avg_timer_write as w_wait_avg, max_timer_write as w_wait_max, min_timer_write as w_wait_min
FROM performance_schema.file_summary_by_instance
WHERE file_name NOT LIKE '%performance_schema%'
ORDER BY $_mlt_L3T1_order_by DESC
LIMIT $_mlt_L3T1_limit_count
;
";




_mlt_tracelog_file="mlt.L3_db_01_oflm.tlog";
touch $_mlt_tracelog_file;
mysql -p$_mlt_L3_db_root_pw -u root -e "$_sqlstmt__get__oflm__perfile_io_summary" >> $_mlt_tracelog_file;
sleep $_mlt_La_measure_duration_in_sec;
mysql -p$_mlt_L3_db_root_pw -u root -e "$_sqlstmt__get__oflm__perfile_io_summary" >> $_mlt_tracelog_file;




#SELECT file_name as perfile_io_summary_fname,
#	event_name as event,
#	count_star as a_count,
#	count_read as r_count,
#	count_write as w_count,
#	sum_number_of_bytes_read as r_bytes,
#	sum_number_of_bytes_write as w_bytes,
#	sum_timer_wait as a_wait_sum, avg_timer_wait as a_wait_avg, max_timer_wait as a_wait_max, min_timer_wait as a_wait_min,
#	sum_timer_read as r_wait_sum, avg_timer_read as r_wait_avg, max_timer_read as r_wait_max, min_timer_read as r_wait_min,
#	sum_timer_write as w_wait_sum, avg_timer_write as w_wait_avg, max_timer_write as w_wait_max, min_timer_write as w_wait_min
#FROM performance_schema.file_summary_by_instance
#WHERE file_name NOT LIKE '%performance_schema%'
#ORDER BY $_mlt_L3T1_order_by DESC
#LIMIT $_mlt_L3T1_limit_count
#;
