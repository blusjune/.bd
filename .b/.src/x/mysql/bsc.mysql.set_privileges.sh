#!/bin/sh
## 20121002_224758


_password_default="mypswd";
_mysql_cmdfile="mysql_setup_for_blusjune.sql";

read -p "BSC> type password for mysql root: " _pswd;
if [ "X$_pswd" = "X" ]; then
	_pswd="$_password_default";
fi

cat > $_mysql_cmdfile << EOF
set password for 'root'@'localhost' = password('$_pswd');
grant all privileges on *.* to 'tpcc_user'@'%' identified by '$_password_default' with grant option;
grant all privileges on *.* to 'mysql_guest'@'10.%' identified by '$_password_default' with grant option;
grant all privileges on *.* to 'blusjune'@'%' identified by '$_password_default' with grant option;
grant all privileges on *.* to 'me'@'%' identified by '$_password_default' with grant option;
#grant all on *.* to tpcc_user@'0.0.0.0' identified by 'mypswd';
EOF


mysql -u root -p < $_mysql_cmdfile;


