#!/bin/sh
#./A/.bdx.0100.y.iowa_anal.sh
#_ver=20130424_001228




#_target="msnfs"
#_sig_ioc_percentage="25"
#_iomw_sz_in_minute="30"
#_prd_t1_in_minute="1"
. ../.iowa_anal.conf


_infile="f010.T011.${_target}.out";


_iowa_anal_cmd="bsc.iowa.lsp.anal_s0010";
_anal_id="anal_s0010";
_iomw_sz="$(expr 60000000 \* $_iomw_sz_in_minute)";
_prd_t1="$(expr 60000000 \* $_prd_t1_in_minute)";


_tstamp="$(tstamp)";
_outdir="../${_tdir}/${_infile}.${_anal_id}";


_file_010="$_infile";
_file_020="${_outdir}/f020.${_anal_id}.in";
_file_030="${_outdir}/f030.${_anal_id}.out";
#_file_040="${_outdir}/f040.iomw_acs_cnt.sorted_by_acs_cnt.plot.in";

_mkfile_per_tag()
{
	_fileout="${_outdir}/f040.${_anal_id}.sigio_${_sig_ioc_percentage}.iomwsz_${_iomw_sz}.t1_${_prd_t1}.${_tag}.out";
	cat $_file_030 | grep $_tag > $_fileout;
}

_tstamp_begin=".job_begin__$(tstamp)"; touch ${_outdir}/${_tstamp_begin}; echo "$_tstamp_begin";
cat $_file_010 | awk '{ print $5, ",", $14 }' > $_file_020
cat $_file_020 | $_iowa_anal_cmd -c $_sig_ioc_percentage -w $_iomw_sz -p $_prd_t1 > $_file_030

_tstamp_finish=".job_finish__$(tstamp)"; touch ${_outdir}/${_tstamp_finish}; echo "$_tstamp_finish";





cat $_file_030 | grep __list__iomw_acs_cnt | awk '{ print $9, $3, $6 }' | sort -n > $_file_040
