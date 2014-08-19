
echo "
The followings SHOULD be executed before this processing:
	.bdx.0214.y.parthenon.2014s1.exec__mk_rcmd__plot_tp10s.sh
	.bdx.0215.n.parthenon.2014s1.mk_rcmd__plot_tp10s.sh
";

#P7N_NUM_COLS=3 export P7N_NUM_COLS;
#P7N_COL_NAMES="xfs ext4 f2fs" export P7N_COL_NAMES;
P7N_NUM_COLS=2 export P7N_NUM_COLS;
P7N_COL_NAMES="dcs3500 pm853t" export P7N_COL_NAMES;

R --save < .rlib.parthenon.2014s1.tpmc_barplot.r
R --save < .rlib.parthenon.2014s1.tp10s_dist_plot.r


