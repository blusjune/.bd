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




_sqlstmt__get__onlm__innodb_metrics="
SELECT UNIX_TIMESTAMP() as 'Tstamp_a', DATE_FORMAT(CURTIME(), '%Y%m%d_%H%i%S') as 'Tstamp_b'\G;
USE information_schema;
SELECT name as innodb_metrics_name,
	subsystem,
	type,
	count,
	max_count,
	avg_count
FROM information_schema.innodb_metrics
WHERE status = 'enabled'
ORDER BY name DESC
;
";




_mlt_tracelog_file="mlt.L3_db_03_oflm.tlog";
touch $_mlt_tracelog_file;
_count=0;
_countlimit=$(expr $_mlt_La_measure_duration_in_sec \/ $_mlt_L3_measure_interval_in_sec);
while [ $_count -lt $_countlimit ]; do
	mysql -p$_mlt_L3_db_root_pw -u root -e "$_sqlstmt__get__onlm__innodb_metrics" >> $_mlt_tracelog_file;
	sleep $_mlt_L3_measure_interval_in_sec;
	_count=$(expr $_count + 1);
done




#SELECT name,
#	subsystem,
#	type,
#	count,
#	max_count,
#	avg_count,
#	time_elapsed,
#	time_enabled
#FROM information_schema.innodb_metrics
#WHERE status = 'enabled'
#ORDER BY name DESC
#;
