_src="bsc.x9.mlt.run_trace";
_exe="mlt.run_trace";
shc -r -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ..;
echo "#>> Build job completed successfully ($_exe)";




# (cd mlt_agent/dbstat-mysql; _BDX);
