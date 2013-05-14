##.bdx.1010.n.gfpsub_b_enpack.sh
##gfp: gpgized file processing
##_ver=20121219_234356
##_ver=20130511_103052; #initial use of 'if [ "#$_value" = "#y" ]; then'
##_ver=20130514_111932




_conf_b__enpack="n"; # default: "n"




if [ "X$_conf_b__enpack" = "Xy" ]; then  # a chance to disable this operation
#------------------------------------------------
	echo "#>> update ~/.bd/.b (with ~/.b)"
	~/.b/.bdx.d/.bdx.0200.y.clear_pyc.sh;
	rm -fr ~/.bd/.b;
	cp -pr ~/.b ~/.bd/;
	(cd ~/.bd/.b/; rm -fr ..bpk/; mkdir ..bpk)
#------------------------------------------------
else
	echo "#>> NOT EXECUTED by conf";
fi




