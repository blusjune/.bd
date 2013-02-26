#!/bin/sh
#.bdx.0100.y.preproc__extract_base_data.sh
#_ver=20130226_210416
#_ver=20130226_220547


#bsc.iowa.extract_rawdata_from_blkparselog .tracelog Q


_proc_10()
{
	_of_p1="${_if}.p1.out";
	_of_A_addr="${_if}.A.addr";
	_of_R_addr="${_if}.R.addr";
	_of_W_addr="${_if}.W.addr";

	cat $_if | bsc.iowa.lsp.preproc_bpout_s10 -p Q > $_of_p1;

	cat $_of_p1 | awk '{ print $4, $5 }' > $_of_A_addr
	cat $_of_p1 | grep '_R' | awk '{ print $4, $5 }' > $_of_R_addr
	cat $_of_p1 | grep '_W' | awk '{ print $4, $5 }' > $_of_W_addr
}


#_if=".tracelog";
_if=".tracelog.fileserver"; _proc_10;
_if=".tracelog.networkfs"; _proc_10;
_if=".tracelog.varmail"; _proc_10;
_if=".tracelog.videoserver"; _proc_10;
_if=".tracelog.webserver"; _proc_10;
