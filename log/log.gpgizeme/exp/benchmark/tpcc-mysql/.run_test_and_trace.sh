#!/bin/sh
#_author="Brian M. JUNG <brian.m.jung@gmail.com>"
#_ver="20140206_121817"
#_ver="20140206_220131"




#_tparam__running_time="600";
_tparam__running_time="28800";
#_tparam__num_of_connections="128";
_tparam__num_of_connections="256";




_tstamp=$(tstamp);
_tid="TID_${_tstamp}";
_tinfo=".tinfo.${_tid}.txt";
_test_cmd="./tpcc_start -h 127.0.0.1 -d tpcc_1000 -u root -p kkk -w 1000 -c $_tparam__num_of_connections -r 10 -l $_tparam__running_time -i 10";
_test_execlog="execlog.${_tid}.txt";




#
# execute benchmark
#
(
if [ ! -d $_tid ]; then
	echo "#>> $_tid is created";
	mkdir $_tid;
	if [ ! -d $_tid ]; then
		echo "#>> ERROR in creating $_tid -- EXIT 1";
		exit 1;
	fi
fi
cd $_tid;




	#
	# collect tracelog
	#
	read -p "#<< start traces? [Y|n] " _ans;
	if [ "X$_ans" = "Xy" ]; then
		(
		_tracelog_dir="/x/tracelog/$_tid";
		if [ ! -d $_tracelog_dir ]; then
			echo "#>> $_tracelog_dir is created";
			mkdir -p $_tracelog_dir;
			if [ ! -d $_tracelog_dir ]; then
				echo "#>> ERROR in creating $_tracelog_dir -- EXIT 1";
				exit 1;
			fi	
		fi
		ln -s $_tracelog_dir tracelog;
		cd $_tracelog_dir;
		
		iostat -xt 60 > log.iostat &
		_pid_iostat="$!";
		top -b -d 60 > log.top &
		_pid_top="$!";
		blktrace /dev/sde &
		_pid_blktrace="$!";
		
		_kill_trace=".kill_trace.sh";
		cat > $_kill_trace << EOF
#!/bin/sh
echo "#>> iostat($_pid_iostat), top($_pid_top), and blktrace($_pid_blktrace) will be killed"
sudo kill $_pid_iostat $_pid_top $_pid_blktrace;
EOF
		chmod 755 $_kill_trace;
		echo "#>> $_kill_trace script executable is created"
		)
	fi




ln -s ../tpcc_load;
ln -s ../tpcc_start;




echo "TEST_CMD# $_test_cmd" > $_tinfo;
mysql --version >> $_tinfo;
sudo cp /etc/mysql/my.cnf my.cnf.${_tid}

mysql -pkkk -u root -e "SHOW VARIABLES LIKE '%'" > mysql_var.all.${_tid}.t1.txt;
mysql -pkkk -u root -e 'SHOW GLOBAL STATUS;' > mysql_status.global.${_tid}.t1.txt;
mysql -pkkk -u root -e 'SHOW ENGINE INNODB STATUS\G;' > mysql_status.innodb_engine.${_tid}.t1.txt;
#mysql -pkkk -u root -e "SHOW VARIABLES LIKE '%query_cache%'" > mysql_var.query_cache.${_tid}.t1.txt;
#mysql -pkkk -u root -e "SHOW STATUS LIKE '%qcache%'" > mysql_status.qcache.${_tid}.t1.txt;
#mysql -pkkk -u root -e "SHOW VARIABLES LIKE '%innodb%'" > mysql_var.innodb.${_tid}.t1.txt;
#mysql -pkkk -u root -e "SHOW STATUS LIKE '%innodb%'" > mysql_status.innodb.${_tid}.t1.txt;

echo "#>> benchmark starts now";
tstamp >> $_tinfo;
$_test_cmd  > $_test_execlog;
tstamp >> $_tinfo;
echo "#>> benchmark finished";

mysql -pkkk -u root -e "SHOW VARIABLES LIKE '%'" > mysql_var.all.${_tid}.t2.txt;
mysql -pkkk -u root -e 'SHOW GLOBAL STATUS;' > mysql_status.global.${_tid}.t2.txt;
mysql -pkkk -u root -e 'SHOW ENGINE INNODB STATUS\G;' > mysql_status.innodb_engine.${_tid}.t2.txt;
#mysql -pkkk -u root -e "SHOW VARIABLES LIKE '%query_cache%'" > mysql_var.query_cache.${_tid}.t2.txt;
#mysql -pkkk -u root -e "SHOW STATUS LIKE '%qcache%'" > mysql_status.qcache.${_tid}.t2.txt;
#mysql -pkkk -u root -e "SHOW VARIABLES LIKE '%innodb%'" > mysql_var.innodb.${_tid}.t2.txt;
#mysql -pkkk -u root -e "SHOW STATUS LIKE '%innodb%'" > mysql_status.innodb.${_tid}.t2.txt;
)




#mysql -pkkk -u root -e "SHOW VARIABLES LIKE '%query_cache%'"
#mysql -pkkk -u root -e "SHOW STATUS LIKE '%qcache%'"
#mysql -pkkk -u root -e "SET GLOBAL query_cache_size = 0"
#mysql -pkkk -u root -e "SET GLOBAL query_cache_type = 0"
#mysql -pkkk -u root -e "SHOW VARIABLES LIKE '%query_cache%'"
#mysql -pkkk -u root -e "SHOW STATUS LIKE '%qcache%'"
