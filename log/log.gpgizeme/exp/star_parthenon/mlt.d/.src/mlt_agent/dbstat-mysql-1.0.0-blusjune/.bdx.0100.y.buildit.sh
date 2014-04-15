_SHC_OPT="-r"
#_SHC_OPT="-r -D -T -l --"



_src=".mlt_dbstat_01_oflm.sh";
_exe=".mlt_dbstat_01_oflm";
shc $_SHC_OPT -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ../../../bin;
echo "#>> Build job completed successfully ($_exe)";




_src=".mlt_dbstat_02_onlm.sh";
_exe=".mlt_dbstat_02_onlm";
shc $_SHC_OPT -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ../../../bin;
echo "#>> Build job completed successfully ($_exe)";




_src=".mlt_dbstat_03_onlm.sh";
_exe=".mlt_dbstat_03_onlm";
shc $_SHC_OPT -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ../../../bin;
echo "#>> Build job completed successfully ($_exe)";




