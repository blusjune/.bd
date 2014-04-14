_src=".mlt_idxer.sh";
_exe=".mlt_idxer";
shc -r -f $_src;
rm ${_src}.x.c;

mv ${_src}.x $_exe;
chmod 775 $_exe;
mv $_exe ../../../bin;
echo "#>> Build job completed successfully";
