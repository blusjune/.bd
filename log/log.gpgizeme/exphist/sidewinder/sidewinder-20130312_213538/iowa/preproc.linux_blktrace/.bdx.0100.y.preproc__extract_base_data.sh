#!/bin/sh
#.bdx.0100.y.preproc__extract_base_data.sh
#_ver=20130226_210416
#_ver=20130226_220547
#_ver=20130305_031734


#bsc.iowa.extract_rawdata_from_blkparselog .tracelog Q


_proc_10()
{
	_of_p1="${_if}.p1.out";
	_of_A_addr="${_if}.A.addr";
	_of_R_addr="${_if}.R.addr";
	_of_W_addr="${_if}.W.addr";
	_tdir="tdir";

	cat $_if | bsc.iowa.lsp.preproc_bpout_s010 -p Q > $_tdir/$_of_p1;

	cat $_tdir/$_of_p1 | awk '{ print $4, $5 }' > $_tdir/$_of_A_addr
	cat $_tdir/$_of_p1 | grep '_R' | awk '{ print $4, $5 }' > $_tdir/$_of_R_addr
	cat $_tdir/$_of_p1 | grep '_W' | awk '{ print $4, $5 }' > $_tdir/$_of_W_addr
}


#_if=".tracelog";
#_if="tracelog.fileserver"; _proc_10;
#_if="tracelog.networkfs"; _proc_10;
#_if="tracelog.varmail"; _proc_10;
#_if="tracelog.videoserver"; _proc_10;
#_if="tracelog.webserver"; _proc_10;
#_if="tracelog.all5"; _proc_10;
_if="tracelog.varmail.log"; _proc_10;
