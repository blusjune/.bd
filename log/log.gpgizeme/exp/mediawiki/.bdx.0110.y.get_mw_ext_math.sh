if [ ! -d extensions ]; then
	echo "#>> mkdir extensions";
	mkdir extensions;
fi
(cd extensions; git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Math.git;)

echo "

1. Add the following to LocalSettings.php:
	require_once(\"\$IP/extensions/Math/Math.php\");
2. Might also have to add:
	\$wgTexvc = '/your/path/to/texvc';
3. Run update.php as you would if you were upgrading:
	php /var/lib/mediawiki/maintenance/update.php;
4. Installation can now be verified through your wiki's Special:Version page

";
