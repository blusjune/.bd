#!/bin/sh

## bsc.mysql.help.sh
## 20121002_231059


_mysql_cnf="/etc/mysql/my.cnf"




echo "-----";
echo "BDX> Add the following lines to '$_mysql_cnf' under the section '[mysqld]'";
echo "
default-storage-engine=innodb
innodb_thread_concurrency=1
innodb_file_per_table=0
innodb_doublewrite=0
innodb_buffer_pool_size=1G
innodb_additional_mem_pool_size=19M
innodb_log_buffer_size=1M
innodb_flush_log_at_trx_commit=2

#bind-address = 127.0.0.1
bind-address = 0.0.0.0
";




echo "-----";
echo "BDX> Please disable AppArmor for mysqld and mysqld-akonadi
to make changed /etc/mysql/my.cnf work";
echo "
$ sudo aptitude -y install apparmor-utils;
$ sudo aa-status;
$ sudo aa-disable;	# and then type 'mysqld' and 'mysqld-akonadi'
";




echo "-----";
echo "BDX> Please set privileges properly to allow remote access to this MySQL daemon";
echo "
e.g.,
mysql> set password for 'root'@'localhost' = password('$_pswd');
mysql> grant all privileges on *.* to 'tpcc_user'@'%' identified by '$_password_default' with grant option;
mysql> grant all privileges on *.* to 'mysql_guest'@'10.%' identified by '$_password_default' with grant option;
mysql> grant all privileges on *.* to 'me'@'%' identified by '$_password_default' with grant option;
";

