##.bdx.0110.n.gfp_bdx_copy.sh
##gfp: gpgized file processing
##_ver=20121219_234356
##_ver=20130207_023212
##_ver=20130217_235424
##_ver=20130429_150652
##_ver=20130511_103052; #initial use of 'if [ "#$_value" = "#y" ]; then'


_conf_b__enpack="n"; # default: "n"
_conf_wikini__enpack="y"; # default: "n"
_conf_wikini__root="${HOME}/.blib/wiki/wikini";
_conf_wikini__target_db="wikidb";
_conf_wikini__mediawiki_var_root="/var/lib/mediawiki";
_conf_wikini__script_file_to_update_db="mysql_wikidb_update.sh";




if [ "#$_conf_b__enpack" = "#y" ]; then  # a chance to disable this operation
#------------------------------------------------
	echo "#>> update ~/.bd/.b (with ~/.b)"
	~/.b/.bdx.d/.bdx.0200.y.clear_pyc.sh;
	rm -fr ~/.bd/.b;
	cp -pr ~/.b ~/.bd/;
	(cd ~/.bd/.b/; rm -fr ..bpk/; mkdir ..bpk)
#------------------------------------------------
fi




if [ "#$_conf_wikini__enpack" = "#y" ]; then
#------------------------------------------------
	if [ ! -d $_conf_wikini__root ]; then
		mkdir -p $_conf_wikini__root;
	fi

	(
		cd $_conf_wikini__root;
	
		_sql_dump_file="${_conf_wikini__target_db}.sql";
		_var_lib_mediawiki_images_tarball="var_lib_mediawiki_images.tgz";
		_sql_dump_dir="sql_dump";
		_wiki_images_dir="wiki_images";

		rm -f .tstamp.*;
		touch .tstamp.$(_tstamp);
	
		echo "#>> execute mysqldump for '$_conf_wikini__target_db' -> $_sql_dump_file";
		if [ ! -d $_sql_dump_dir ]; then
			mkdir -p $_sql_dump_dir;
		fi
		(
			cd $_sql_dump_dir;
			mysqldump -p -u root $_conf_wikini__target_db > $_sql_dump_file;
			split -a 5 -l 10 -d $_sql_dump_file _sql_; sync; sleep 2; rm $_sql_dump_file;
		)
	
		echo "#>> enpack the uploaded $_conf_wikini__target_db images";
		if [ ! -d $_wiki_images_dir ]; then
			mkdir -p $_wiki_images_dir;
		fi
		(cd $_conf_wikini__mediawiki_var_root; sudo tar cf - images) | gzip -c > ${_wiki_images_dir}/${_var_lib_mediawiki_images_tarball};

		echo "#>> create a script file to update mysql database '$_conf_wikini__target_db' with the latest version";
		cat > $_conf_wikini__script_file_to_update_db << EOF
#!/bin/sh
ln -s /x/t/share tmp;
_tstamp=\$(ls -1 .tstamp.* | sed -e 's/\.tstamp\.\(.*\)/\1/g');
_sql_wikidb="wikidb-\${_tstamp}.sql";
cat ${_sql_dump_dir}/_sql_* > tmp/\$_sql_wikidb;
echo "drop database $_conf_wikini__target_db; create database $_conf_wikini__target_db;" | mysql -p -u root;
mysql -p -u root $_conf_wikini__target_db < tmp/\$_sql_wikidb;
EOF
		chmod 755 $_conf_wikini__script_file_to_update_db;

	)
#------------------------------------------------
fi




