

_src_v1_0="bsc.x9.mlt.run_trace-v1";
_exe_v1_0="mlt.run_trace-v1";

_src_v2_0="bsc.x9.mlt.run_trace-v2";
_exe_v2_0="mlt.run_trace-v2";


_build_mlt_bin()
{
CFLAGS="$CFLAGS -static" export CFLAGS;
shc -r -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ..;
echo "#>> Build job completed successfully ($_exe)";
}


_src=$_src_v2_0 _exe=$_exe_v2_0 _build_mlt_bin;


# (cd mlt_agent/dbstat-mysql; _BDX);
