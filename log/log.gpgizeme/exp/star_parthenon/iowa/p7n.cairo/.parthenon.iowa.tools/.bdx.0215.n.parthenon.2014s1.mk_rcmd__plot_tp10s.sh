#!/bin/sh
#20140523_222740


_prefix_dlist_a="L3_C";
_fslist="xfs ext4 f2fs";
_fslist_wcw=$(echo $_fslist | wc -w);
_dlist_a=$(ls -1d * | grep $_prefix_dlist_a);
_dlist_a_wcw=$(echo $_dlist_a | wc -w);


plot_it()
{
	_count=$(echo $_files | wc -w);
	echo "set multiplot layout $_count, 1" >> $_gpcmd;
	for _i in $_files; do
		echo "plot '$_i' u 1 w l;" >> $_gpcmd;
	done
}


echo "
par(mfcol=c($_dlist_a_wcw, $_fslist_wcw));
";
_df_list="";
_name_list="";
_ca=0;
for _ia in $_fslist; do
	_ca=$(expr $_ca + 1);
	_cb=0;
	for _ib in $_dlist_a; do
		_cb=$(expr $_cb + 1);
		_tp10s_file=$( find . -name 'tpcc.p030.tp10s_trx1.jung' | grep $_ia | grep $_ib );
		_name="$_ia.$_ib";
		_df="tp10s.$_name";
		echo "$_df <- read.table('$_tp10s_file')"

		if [ "X$_df_list" != "X" ]; then
			_df_list="$_df_list , $_df";
		else
			_df_list="$_df";
		fi
		if [ "X$_name_list" != "X" ]; then
			_name_list="$_name_list , \"$_name\"";
		else
			_name_list="\"$_name\"";
		fi

	done
done
echo "
dflist <- list($_df_list);
namelist <- list($_name_list);
ymax <- max(unlist(dflist));
";
echo "
for (i in 1:length(dflist)) {
	plot.ts(unlist(dflist[i]), ylim=c(0,ymax), main=namelist[i]);
}
";
