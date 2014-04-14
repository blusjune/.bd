#!/bin/sh
#_ver=20140408_170831
#_ver=20140409_074228




_num_param=3;
if [ $# != $_num_param ]; then
	echo "#>> ERROR: check the number of parameters (should be $_num_param) -- EXIT";
	exit 1;
else
	_mlt_La_measure_duration_in_sec=$1
	_mlt_L3_measure_interval_in_sec=$2
	_mlt_L3_db_root_pw=$3;
fi




# oflm: offline metric
# onlm: online metric




_sqlstmt__get__onlm__innodb_buffer_pool_stats="
SELECT UNIX_TIMESTAMP() as 'Tstamp_a', DATE_FORMAT(CURTIME(), '%Y%m%d_%H%i%S') as 'Tstamp_b'\G;
USE information_schema;
SELECT pool_id as innodb_buffer_pool_stats_plid,
	pool_size as plsz,
	free_buffers as plsz_free,
	database_pages as dbpg,
	old_database_pages as dbpg_old,
	modified_database_pages as dbpg_mod,
	pages_made_young as pg_young,
	pages_not_made_young as pg_no_young,
	number_pages_read as r_pages,
	number_pages_created as c_pages,
	number_pages_written as w_pages,
	pending_reads as r_pend,
	lru_io_total as lru_io_tot,
	lru_io_current as lru_io_cur,
	hit_rate
FROM information_schema.innodb_buffer_pool_stats
;
";




_mlt_tracelog_file="mlt.L3_db_02_onlm.tlog";
touch $_mlt_tracelog_file;
_count=0;
_countlimit=$(expr $_mlt_La_measure_duration_in_sec \/ $_mlt_L3_measure_interval_in_sec);
while [ $_count -lt $_countlimit ]; do
	mysql -p$_mlt_L3_db_root_pw -u root -e "$_sqlstmt__get__onlm__innodb_buffer_pool_stats" >> $_mlt_tracelog_file;
	sleep $_mlt_L3_measure_interval_in_sec;
	_count=$(expr $_count + 1);
done




