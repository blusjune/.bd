##.bdx.0110.n.gfp_bdx_copy.sh
##gfp: gpgized file processing
##_ver=20121219_234356
##_ver=20130207_023212
##_ver=20130217_235424


echo "#>> update ~/.bd/.b (with ~/.b)"
~/.b/.bdx.d/.bdx.0200.y.clear_pyc.sh;
rm -fr ~/.bd/.b;
cp -pr ~/.b ~/.bd/;
(cd ~/.bd/.b/; rm -fr ..bpk/; mkdir ..bpk)


