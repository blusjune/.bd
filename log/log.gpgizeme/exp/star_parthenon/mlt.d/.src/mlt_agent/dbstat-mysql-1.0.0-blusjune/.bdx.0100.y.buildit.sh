



_src=".mlt_dbstat_01_oflm.sh";
_exe=".mlt_dbstat_01_oflm";
shc -r -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ../../../bin;
echo "#>> Build job completed successfully ($_exe)";




_src=".mlt_dbstat_02_onlm.sh";
_exe=".mlt_dbstat_02_onlm";
shc -r -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ../../../bin;
echo "#>> Build job completed successfully ($_exe)";




_src=".mlt_dbstat_03_onlm.sh";
_exe=".mlt_dbstat_03_onlm";
shc -r -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ../../../bin;
echo "#>> Build job completed successfully ($_exe)";




