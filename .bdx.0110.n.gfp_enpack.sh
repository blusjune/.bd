##.bdx.0110.n.gfp_bdx_copy.sh
##gfp: gpgized file processing
##_ver=20121219_234356
##_ver=20130207_023212
##_ver=20130217_235424
##_ver=20130429_150652
##_ver=20130511_103052; #initial use of 'if [ "#$_value" = "#y" ]; then'




_list=$(ls -1 .bdx.*.n.gfpsub_*_enpack.sh);
for _i in $_list; do
	echo "#>> Executes: $_i";
	. $_i;
done




