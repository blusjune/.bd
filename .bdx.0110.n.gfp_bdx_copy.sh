##.bdx.0110.n.gfp_bdx_copy.sh
##gfp: gpgized file processing
##_ver=20121219_234356
##_ver=20130207_023212
##_ver=20130217_235424
##_ver=20130429_150652
##_ver=20130511_103052; #initial use of 'if [ "#$_value" = "#y" ]; then'


_conf__b_enpack="n"; # default: "n"
_conf__wikini_enpack="n"; # default: "n"
_conf__wikini_enpack__wikini_dir="~/.blib/wiki/wikini";




if [ "#$_conf__b_enpack" = "#y" ]; then  # a chance to disable this operation
#------------------------------------------------
	echo "#>> update ~/.bd/.b (with ~/.b)"
	~/.b/.bdx.d/.bdx.0200.y.clear_pyc.sh;
	rm -fr ~/.bd/.b;
	cp -pr ~/.b ~/.bd/;
	(cd ~/.bd/.b/; rm -fr ..bpk/; mkdir ..bpk)
#------------------------------------------------
fi




if [ "#$_conf__wikini_enpack" = "#y" ]; then
#------------------------------------------------
	if [ ! -d $_conf__wikini_enpack__wikini_dir ]; then
		mkdir -p $_conf__wikini_enpack__wikini_dir;
	fi
	(
	cd $_conf__wikini_enpack__wikini_dir;
	pwd;
	echo ">> execute mysqldump for 'wikidb'";
	echo ">> copy the uploaded wikini media data to the memory store";
	)
#------------------------------------------------
fi
