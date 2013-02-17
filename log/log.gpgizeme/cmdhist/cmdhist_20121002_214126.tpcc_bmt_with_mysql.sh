#!/bin/sh
## 20121002_153537
## BenchmarkSQL (TPC-C test against MySQL)




mkdir work;
cd work;




## --------------------------------------------------------------------------------
## Please make sure that you have:
## mysql-server-5.1
## jdk-6
## --------------------------------------------------------------------------------
## $ aptitude search mysql | grep '^i';
##
## i   libmysql-java                   - Java database (JDBC) driver for MySQL     
## i A mysql-client-core-5.1           - MySQL database core client binaries       
## i   mysql-common                    - MySQL database common files, e.g. /etc/mys
## i A mysql-server                    - MySQL database server (metapackage dependi
## i A mysql-server-5.1                - MySQL database server binaries and system 
## --------------------------------------------------------------------------------
## $ aptitude search jdk | grep '^i';
##
## i   openjdk-6-dbg                   - Java runtime based on OpenJDK (debugging s
## i   openjdk-6-doc                   - OpenJDK Development Kit (JDK) documentatio
## i   openjdk-6-jre                   - OpenJDK Java runtime, using Hotspot JIT   
## i A openjdk-6-jre-headless          - OpenJDK Java runtime, using Hotspot JIT (h
## i A openjdk-6-jre-lib               - OpenJDK Java runtime (architecture indepen
## i   openjdk-6-source                - OpenJDK Development Kit (JDK) source files
## i   openjdk-7-demo                  - Java runtime based on OpenJDK (demos and e
## i   openjdk-7-doc                   - OpenJDK Development Kit (JDK) documentatio
## i   openjdk-7-jdk                   - OpenJDK Development Kit (JDK)             
## i A openjdk-7-jre-headless          - OpenJDK Java runtime, using Hotspot JIT (h
## i A openjdk-7-jre-lib               - OpenJDK Java runtime (architecture indepen
## i   openjdk-7-source                - OpenJDK Development Kit (JDK) source files
## --------------------------------------------------------------------------------




## Download the BenchmarkSQL software
read -p "Download BenchmarkSQL -- which way do you want? [\"chrome\"|\"wget\"] " _ans;
if [ "X$_ans" = "Xchrome" ]; then
	google-chrome http://sourceforge.net/projects/benchmarksql/?source=directory;
else
	wget http://downloads.sourceforge.net/project/benchmarksql/BenchmarkSQL-2.3.3.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbenchmarksql%2Ffiles%2F&ts=1349160325&use_mirror=jaist;
fi

## unzip the BenchmarkSQL package
unzip BenchmarkSQL-2.3.3.zip;

## build the BenchmarkSQL testsuite
cd BenchmarkSQL-2.3.3;
ant; ant jar;




## check mysql DB (assuming that you already setup the mysql root password)
mysql -u root -p;


## --------------------------------------------------------------------------------
## Please make sure InnoDB engine is supported.
## --------------------------------------------------------------------------------
## mysql> show engines;
## --------------------------------------------------------------------------------


## --------------------------------------------------------------------------------
## Change the default DB engine to InnoDB
## --------------------------------------------------------------------------------
## Add the following lines to /etc/mysql/my.cnf under the [mysqld]
##
## $ vi /etc/mysql/my.cnf;
##
## default-storage-engine=innodb
## innodb_thread_concurrency=1
## innodb_file_per_table=0
## innodb_doublewrite=0
## innodb_buffer_pool_size=1G
## innodb_additional_mem_pool_size=19M
## innodb_log_buffer_size=1M
## innodb_flush_log_at_trx_commit=2
## 
## # Instead of skip-networking the default is now to listen only on
## # localhost which is more compatible and is not less secure.
## # bind-address            = 127.0.0.1
## bind-address            = 192.168.1.25
##
## $ /etc/init.d/mysql restart;
## --------------------------------------------------------------------------------




cd run;
## --------------------------------------------------------------------------------
## Create DB
## --------------------------------------------------------------------------------
## $ mysql -u root -p;
## mysql> show databases;
## mysql> create database tpcc_125g;
## mysql> show databases;
## mysql> show tables from tpcc_125g;
## mysql> show table status from tpcc_125g;
## --------------------------------------------------------------------------------


## --------------------------------------------------------------------------------
## [optional] Drop the DB (only if you want)
## --------------------------------------------------------------------------------
## mysql> drop database tpcc_125g;
## --------------------------------------------------------------------------------


## --------------------------------------------------------------------------------
## Create TPC-C table using predefined SQL script (provided by BenchmarkSQL)
## --------------------------------------------------------------------------------
mysql -u root -p tpcc_125g < sqlTableCreates;


## --------------------------------------------------------------------------------
## [optional] Check the status of DB and tables
## --------------------------------------------------------------------------------
## mysql> show databases;
## mysql> use tpcc_125g;
## mysql> show tables;
## +---------------------+
## | Tables_in_tpcc_125g |
## +---------------------+
## | customer            |
## | district            |
## | history             |
## | item                |
## | new_order           |
## | oorder              |
## | order_line          |
## | stock               |
## | warehouse           |
## +---------------------+
## mysql> show table status;
## --------------------------------------------------------------------------------


## --------------------------------------------------------------------------------
## Create TPC-C table index using predefined SQL script (provided by BenchmarkSQL)
## --------------------------------------------------------------------------------
mysql -u root -p tpcc_125g < sqlIndexCreates;

## --------------------------------------------------------------------------------
## Analyze TPC-C table 'manually'
## Because, in my case, "mysql> vacuum analyze;" SQL command does not work well
## , which resides at final line of sqlIndexCreates file
## --------------------------------------------------------------------------------
## mysql> help analyze;
## mysql> help analyze table;
## mysql> analyze table customer, district, history, item, new_order, oorder, order_line, stock, warehouse;
## --------------------------------------------------------------------------------




## --------------------------------------------------------------------------------
## Install 3rd-party library (if not installed) -- libmysql-java
## --------------------------------------------------------------------------------
cd ../..;
mkdir 3rd_party_sw;
cd 3rd_party_sw;

## Unfortunately, the following command line does not work properly in my case.
sudo aptitude -y install libmysql-java;

## So I decided to use direct download of .deb file
# google-search "libmysql-java ubuntu 11.10";
wget http://security.ubuntu.com/ubuntu/pool/main/m/mysql-connector-java/libmysql-java_5.1.10+dfsg-2ubuntu1_all.deb;
dpkg -i libmysql-java_5.1.10+dfsg-2ubuntu1_all.deb;
sudo updatedb;
locate libmysql-java;

## /home/blusjune/bx_data/tsk/2012/10/02/t01.tpc_bmt/work/pre-install/libmysql-java_5.1.10+dfsg-2ubuntu1_all.deb
## /usr/share/doc/libmysql-java
## /usr/share/doc/libmysql-java/EXCEPTIONS-CONNECTOR-J.gz
## /usr/share/doc/libmysql-java/README
## /usr/share/doc/libmysql-java/README.Debian
## /usr/share/doc/libmysql-java/changelog.Debian.gz
## /usr/share/doc/libmysql-java/copyright
## /var/lib/dpkg/info/libmysql-java.list
## /var/lib/dpkg/info/libmysql-java.md5sums

cat /var/lib/dpkg/info/libmysql-java.list;

## /.
## /usr
## /usr/share
## /usr/share/java
## /usr/share/java/mysql-connector-java-5.1.10.jar
## /usr/share/doc
## /usr/share/doc/libmysql-java
## /usr/share/doc/libmysql-java/changelog.Debian.gz
## /usr/share/doc/libmysql-java/README
## /usr/share/doc/libmysql-java/README.Debian
## /usr/share/doc/libmysql-java/copyright
## /usr/share/doc/libmysql-java/EXCEPTIONS-CONNECTOR-J.gz
## /usr/share/java/mysql-connector-java.jar
## /usr/share/java/mysql-5.1.10.jar
## /usr/share/java/mysql.jar

cp -p /usr/share/java/mysql-connector-java-5.1.10.jar ../BenchmarkSQL-2.3.3/lib/;
## --------------------------------------------------------------------------------




## --------------------------------------------------------------------------------
## Inserting directly to TPC-C DB without creating CSV file
## --------------------------------------------------------------------------------
cd ../BenchmarkSQL-2.3.3/run/;
cp loadData.sh loadData_mysql.sh;

cat > loadData_mysql.sh << EOF_1
\$JAVA_HOME/bin/java -cp ../lib/mysql-connector-java-5.1.10.jar:../lib/edb-jdbc14-8_0_3_14.jar:../lib/ojdbc14-10.2.jar:../lib/postgresql-8.0.309.jdbc3.jar:../lib/db2jcc.jar:../dist/BenchmarkSQL-2.3.jar  -Dprop=\$1 LoadData numwarehouses 50
EOF_1

cat > mysql.prop << EOF_2
driver=com.mysql.jdbc.Driver
conn=jdbc:mysql://localhost:3306/tpcc_125g
user=root
password=kkk
EOF_2

./loadData_mysql.sh mysql.prop;




## --------------------------------------------------------------------------------
## BenchmarkSQL execution
## --------------------------------------------------------------------------------
cp runBenchmark.sh runBenchmark_mysql.sh;
cat > runBenchmark_mysql.sh << EOF_3
\$JAVA_HOME/bin/java -server -Xms128M -Xmx128M -cp ../lib/mysql-connector-java-5.1.10.jar:../dist/BenchmarkSQL-2.3.jar -Dprop=\$1 jTPCC
EOF_3
./runBenchmark_mysql.sh mysql.prop;



















