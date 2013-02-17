#!/bin/sh

##bsc.iowa.readme.sh
##_ver=20130107_204117
_ver=20130116_010813
_ver=20130207_021957




echo "------";
echo "README # $_ver";
echo "
bsc.iowa.
[*] analyze_blkparselog.sh						: *** top-level script (please just use this file) ***
[ ] lsp.addr.hit_freq.py						: LSP (Line-by-line Stream Processing) for hit frequency pattern
[ ] lsp.addr.range_runs_freq.py					: LSP (Line-by-line Stream Processing) for range runs frequency pattern
[ ] lsp.addr.seek_dist_freq.py					: LSP (Line-by-line Stream Processing) for seek distance frequency pattern
[ ] extract_rawdata_from_blkparse_logfile.sh	: will be called by analyze_blkparselog.sh
[ ] mk_hitfreq_dist_table.sh					: will be called by analyze_blkparselog.sh
[ ] readme.sh									: yes, this script!
";
echo "------";


