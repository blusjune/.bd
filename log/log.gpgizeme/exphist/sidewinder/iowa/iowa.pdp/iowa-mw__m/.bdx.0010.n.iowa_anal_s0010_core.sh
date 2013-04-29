#!/bin/sh
#.bdx.0010.n.iowa_anal_s0010_core.sh
#_ver=20130429_145709




_iowa_anal_cmd="bsc.iowa.lsp.anal_s0010";
_anal_code="anal_s0010";
_sigio_ratio="$_sig_ioc_percentage";
_iomw_sz="$(expr 60000000 \* $_iomw_sz_in_minute)";
_prd_t1="$(expr 60000000 \* $_prd_t1_in_minute)";


_tstamp="$(tstamp)";
_iowa_anal_id="iowa_${_anal_code}.sio_${_sigio_ratio}.mw_${_iomw_sz}.t1_${_prd_t1}";
_outdir="../${_tdir}/${_tstamp}--${_infile}--${_iowa_anal_id}";
if [ ! -d $_outdir ]; then
	mkdir -p $_outdir;
fi


_file_010="$_infile";
_file_020="${_outdir}/f020.${_target}.${_anal_code}.in";
_file_030="${_outdir}/f030.${_target}.${_anal_code}.out";
#_file_040="${_outdir}/f040.${_target}.${_anal_code}.${_tag}.out";

_postproc_iowa_output_with_tag()
{
	_file_040="${_outdir}/f040.${_target}.${_anal_code}.${_tag}.out";
	cat $_file_030 | grep $_tag > $_file_040;
}




_tstamp_begin=".job_begin__$(tstamp)"; touch ${_outdir}/${_tstamp_begin}; echo "$_tstamp_begin";

cat $_file_010 | awk '{ print $5, ",", $14 }' > $_file_020;
cat $_file_020 | $_iowa_anal_cmd -c $_sig_ioc_percentage -w $_iomw_sz -p $_prd_t1 > $_file_030;
touch ${_outdir}/.BANNER.${_iowa_anal_id};

_tag="__list__addr_hit_tstamp__"; _postproc_iowa_output_with_tag;
_tag="__cdst__hits_per_addr__"; _postproc_iowa_output_with_tag;
_tag="__cdst__addrs_per_hitnum__"; _postproc_iowa_output_with_tag;
_tag="__valu__sig__"; _postproc_iowa_output_with_tag;
_tag="__list__hitnum_and_addrs__"; _postproc_iowa_output_with_tag;
_tag="__list__sig_hitnum_and_addrs__"; _postproc_iowa_output_with_tag;
_tag="__cdst__addr_hit_interval__"; _postproc_iowa_output_with_tag;
_tag="__list__periodicity_metric__t1_" _postproc_iowa_output_with_tag;
_tag="__list__iomw_acs_cnt_per_addr__"; _postproc_iowa_output_with_tag;

_tag="__list__iomw_acs_cnt_per_addr__" \
_infile_tmp="${_outdir}/f040.${_target}.${_anal_code}.${_tag}.out" \
_infile_for_gnuplot="${_infile_tmp}.for_gnuplot"; \
cat $_infile_tmp | awk '{ print $9, $3, $6 }' | sort -n > ${_infile_for_gnuplot};
_plot_cmd=".plot_acs_cnt.gp";
cat > $_plot_cmd << EOF
clear
unset key
set title "I/O intensiveness (${_iotype_rw})"
set xlabel "time (${_iomw_sz_in_minute}-minute)"
set ylabel "address (LBA)"
set zlabel "hit count per addr"
show view
#set view 45, 60
set view 70, 80
show view
splot '${_infile_for_gnuplot}' u 3:2:1 with points palette pointsize 2 pointtype 7
EOF
echo "'$_plot_cmd' file is created"

_tstamp_finish=".job_finish__$(tstamp)"; touch ${_outdir}/${_tstamp_finish}; echo "$_tstamp_finish";




