#!/bin/sh
#_ver=20140614_152849
# e8t: experiment: e12345678t # 20140614_152809




_tstamp=$(tstamp);
_this_program=$(basename $(echo $0));
_errlog=".bdx.error.log";




. .parthenon.cf;



_target_disk=$_p7n_LmCnnn_target_disk;

echo "#BDX>> IN : blktrace log ('${_target_disk}.blktrace.0, ...')";
echo "#BDX>> OUT: $_bdx_0550_file_rcmd_gwp_blk";
echo "--------------------------------------------------";




_dir_clue="mlt.L2_sys_blk.tlog";
_dirs=$(find $_bdx_0550_root_dir -name $_dir_clue -exec dirname {} \; | grep $_bdx_0550_target_tag | grep $_bdx_0550_find_cond_1)
_cmd_blktr_p010=".bpy.iowa.2014s1.mlt_L2_blktr.p010.py -d $_target_disk -b D";
_gwp_d=".gwp.d";




_gwp_files="";
..ts;
for _i in $_dirs; do
	echo "$_i";
	(cd $_i;
		for _dev in $(ls -1 *.blktrace.* | sed -e 's/\(.*\)\.blktrace\..*/\1/g' | sort -u); do
			if [ "X$_bdx_0550_target_disk" != "X" ]; then
				if [ "X$_dev" != "X$_bdx_0550_target_disk" ]; then
					echo "#BDX:INFO>> skip processing for $_dev (not a target - $_bdx_0550_target_disk)";
					continue;
				fi
			fi
			echo "#BDX>> start processing for $_dev ......"; 
			_tla_blk_p0_raw="blktr.${_dev}.p0.log";
			#_tla_blk_p010_jung="blktr.${_dev}.p010.jung";
			_tla_blk_p010_jung="tla.l2_sys_blk.p010.${_dev}.jung";
			if [ ! -f $_tla_blk_p0_raw ]; then
				if [ $(ls -1 *.blktrace.* | grep $_bdx_0550_target_disk | grep '\.gz' | wc -l) -gt 0 ]; then
					echo "#BDX>> un-zip blktrace files for $_dev ..."; 
					gunzip ${_dev}.blktrace.*.gz;
				fi
				echo "#BDX>> blkparse for $_dev ...";
				.mlt_blkparse -hs $_dev > $_tla_blk_p0_raw;
				if [ ! -f $_tla_blk_p0_raw ]; then
					_errmsg="#BDX:ERROR>> $_tla_blk_p0_raw SHOULD exist -- EXIT";
					echo $_errmsg; echo "$_this_program : $_errmsg" >> $_errlog; exit 1;
				fi
			fi
			if [ ! -d $_gwp_d ]; then
				echo "#BDX>> create directory $_gwp_d";
				mkdir $_gwp_d;
			fi
			if [ ! -f ${_gwp_d}/${_tla_blk_p010_jung} ]; then
				(cd $_gwp_d;
				 	if [ ! -f $_tla_blk_p0_raw ]; then
				 		ln -s ../$_tla_blk_p0_raw;
					fi
					echo "#BDX>> calculating BDX GWP metrics: $_tla_blk_p0_raw -> $_tla_blk_p010_jung ...";
					cat $_tla_blk_p0_raw | $_cmd_blktr_p010 > .tmp.blktr.p010.log;
					_gwp_files="$_gwp_files $(pwd)/$(ls -1 p7n.*.${_dev}.gwp_summary.txt)";
					_p7n_tracelog_p010_jung=$(ls -1 p7n.*.${_dev}.tracelog_p010.txt | tail -1);
					ln -s $_p7n_tracelog_p010_jung $_tla_blk_p010_jung;
				)
			fi
		done
		..ts;
	)
done




if [ "X$_gwp_files" = "X" ]; then
	_gwp_files=$(cat $_bdx_0550_fnrf_gwp_files);
	if [ "X$_gwp_files" = "X" ]; then
		echo "#BDX:ERROR>> '_gwp_files' SHOULD be defined OR '$_bdx_0550_fnrf_gwp_files' SHOULD exist -- EXIT";
		echo $_errmsg; echo "$_this_program : $_errmsg" >> $_errlog; exit 1;
	fi
else
	echo "#BDX>> will read and calculate the GWP polygon for the following files:";
	_count=0;
	for _f in $_gwp_files; do
		_count=$(expr $_count + 1);
		_dt="d.$_count";
		echo "$_dt <- $_f";
	done
fi




_count=0;
_rbind_str_1="";
_num_gwp_files=$(echo $_gwp_files | wc -w);
rm -f $_bdx_0550_file_rcmd_gwp_blk;
echo "

source('.rlib.parthenon.2014s1.colors.r');
source('.rlib.parthenon.2014s1.mk_gwp_polygon.r');

" >> $_bdx_0550_file_rcmd_gwp_blk;
for _f in $_gwp_files; do
	_count=$(expr $_count + 1);
	_dt="d.$_count";
	_rbind_str_tmp=", ${_dt}\$V4";
	_rbind_str_1="$_rbind_str_1 $_rbind_str_tmp";
	echo "$_dt <- read.table('$_f');" >> $_bdx_0550_file_rcmd_gwp_blk;
done

#dt_tcase="d_${_bdx_0550_target_tag}";




####
#### { e8t specific code: start
####
#### Three file systems: xfs, ext4, f2fs
#### Performance benchmark: tpc-c
####

#perf_total_tcase="perf_total_${_bdx_0550_target_tag}";

echo "

loc_xfs = 1;
loc_ext4 = 2;
loc_f2fs = 0;
num_of_tcase = 3;
perf_total <- read.table('dat.perf_total.txt');
rlen_perf_total <- dim(perf_total)[1];
perf_total_tcase <- perf_total[c((1:rlen_perf_total %% num_of_tcase) == loc_${_bdx_0550_target_tag}),]\$V2;

d_col_names <- paste(d.1\$V1, d.1\$V2, sep='');

d.min <- read.table('${_p7n_LmCnnn_dir_aux}/${_bdx_0550_file_gwp_summary_min}');
dt_tcase <- rbind( d.min\$V4 ${_rbind_str_1} );
colnames(dt_tcase) <- d_col_names;
df_tcase <- data.frame(dt_tcase);

d.max <- d.min;
d.max\$V4[15:17] = max(df_tcase\$iocount__a);
d.max\$V4[21:23] = max(df_tcase\$ioamount__a);
#d.max\$V4[c(19, 25, 27:29, 31:33)]
i = 19; d.max\$V4[i] = max(df_tcase[i]);
i = 25; d.max\$V4[i] = max(df_tcase[i]);
i = 27; d.max\$V4[i] = max(df_tcase[i]);
i = 28; d.max\$V4[i] = max(df_tcase[i]);
i = 29; d.max\$V4[i] = max(df_tcase[i]);
i = 31; d.max\$V4[i] = max(df_tcase[i]);
i = 32; d.max\$V4[i] = max(df_tcase[i]);
i = 33; d.max\$V4[i] = max(df_tcase[i]);
dt_tcase <- rbind( d.max\$V4 , d.min\$V4 ${_rbind_str_1} );
colnames(dt_tcase) <- d_col_names;
df_tcase <- data.frame(dt_tcase);

pcol_vec_tcase_tmp <- p7n.gwp.blrd.colors(${_num_gwp_files});
#pcol_vec_tcase_tmp <- hsv(h=seq.int(from=70/100, to=1/100, length.out=${_num_gwp_files}));
pcol_vec_tcase <- c('lightgray', 'lightgray', pcol_vec_tcase_tmp[rank(-1 * perf_total_tcase)]);

#polygon_ad0_axis_select <- c(-3, -(6:8), -10, -11, -13, -14, -15, -18, -20, -21, -24, -26, -27, -30, -31, -34);
polygon_ad0_axis_sel_1 <- c(1,2,4,5,9,12);
polygon_ad0_axis_sel_2 <- c(16,17,19,22,23,25,28,29,32,33);
p7n_gwp_polygon_ad0 <- function(arg_df, arg_axis_select, arg_pcol, arg_axislabcol='black', arg_title='') {
	p7n_gwp_polygon(arg_df[arg_axis_select], maxmin=F, axistype=2, plwd=2, plty=1, pcol=arg_pcol, axislabcol=arg_axislabcol, title=arg_title);
}

#par(mfrow=c(1,2));
layout(matrix(c(1,2,3,3), 2, 2, byrow=T));

perf_total_tcase_max = max(perf_total_tcase);
text_yoff = perf_total_tcase_max / 20; 
ylim_tcase = perf_total_tcase_max * 1.3;
if (readline(prompt='GWP Polygon?') != 'n') {
	#p7n_gwp_polygon_ad0(arg_df=df_tcase, arg_axis_select=polygon_ad0_axis_select, arg_pcol=pcol_vec_tcase);
        p7n_gwp_polygon_ad0(arg_df=df_tcase, arg_axis_select=polygon_ad0_axis_sel_1, arg_pcol=pcol_vec_tcase, arg_title='GWP Pure IO Pattern');
        p7n_gwp_polygon_ad0(arg_df=df_tcase, arg_axis_select=polygon_ad0_axis_sel_2, arg_pcol=pcol_vec_tcase, arg_title='GWP Interactive IO Pattern');
        bp <- barplot(perf_total_tcase, col=pcol_vec_tcase[3:length(pcol_vec_tcase)], ylim=c(0,ylim_tcase), main='System Performance Result');
        text(bp, perf_total_tcase + text_yoff, perf_total_tcase);
}

" >> $_bdx_0550_file_rcmd_gwp_blk;

####
#### } e8t specific code: end 
####




