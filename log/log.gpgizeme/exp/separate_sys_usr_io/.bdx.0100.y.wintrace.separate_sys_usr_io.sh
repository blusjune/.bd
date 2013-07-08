#!/bin/sh
#.bdx.0100.y.wintrace.separate_sys_usr_io.sh
#_ver="20130708_210515";
#_ver="20130708_223325";




_iotrc_log=".iotrc.txt";
_tstamp="$(tstamp)";
_fileout=".iotrc.proc.${_tstamp}";




sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$Mft' > ${_fileout}.Mft;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$LogFile' > ${_fileout}.LogFile;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\System Volume Information' > ${_fileout}.System_Volume_Information;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$AttrDef' > ${_fileout}.AttrDef;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$BitMap' > ${_fileout}.BitMap;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$Boot' > ${_fileout}.Boot;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$BadClus' > ${_fileout}.BadClus;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$Secure' > ${_fileout}.Secure;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$UpCase' > ${_fileout}.UpCase;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\\$Extend' > ${_fileout}.Extend;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep -e ':\\Windows' > ${_fileout}.Windows;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.sys.${_tstamp}";
cat $_iotrc_log | grep \
-e ':\\\$Mft' \
-e ':\\\$LogFile' \
-e ':\\System Volume Information' \
-e ':\\\$AttrDef' \
-e ':\\\$BitMap' \
-e ':\\\$Boot' \
-e ':\\\$BadClus' \
-e ':\\\$Secure' \
-e ':\\\$UpCase' \
-e ':\\\$Extend' \
-e ':\\Windows' \
> ${_fileout}._sysio_;
ln -s ${_fileout}._sysio_ .iotrc.proc._sysio_.txt








sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.usr.${_tstamp}";
cat $_iotrc_log | grep -e ':\\Users' > ${_fileout}.Users;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.usr.${_tstamp}";
cat $_iotrc_log | grep -e ':\\Program Files' > ${_fileout}.Program_Files;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.usr.${_tstamp}";
cat $_iotrc_log | grep -e ':\\ProgramData' > ${_fileout}.ProgramData;

sleep 1; _tstamp="$(tstamp)"; _fileout=".iotrc.proc.usr.${_tstamp}";
cat $_iotrc_log \
| grep -v ':\\\$Mft' \
| grep -v ':\\\$LogFile' \
| grep -v ':\\System Volume Information' \
| grep -v ':\\\$AttrDef' \
| grep -v ':\\\$BitMap' \
| grep -v ':\\\$Boot' \
| grep -v ':\\\$BadClus' \
| grep -v ':\\\$Secure' \
| grep -v ':\\\$UpCase' \
| grep -v ':\\\$Extend' \
| grep -v ':\\Windows' \
> ${_fileout}._usrio_;
ln -s ${_fileout}._usrio_ .iotrc.proc._usrio_.txt








exit 0;



'
  121971 .iotrc.proc.20130708_204249.Mft
  185357 .iotrc.proc.20130708_204250.LogFile
    2539 .iotrc.proc.20130708_204251.SystemVolumeInformation
       0 .iotrc.proc.20130708_204252.AttrDef
   18180 .iotrc.proc.20130708_204253.BitMap
       0 .iotrc.proc.20130708_204254.Boot
       0 .iotrc.proc.20130708_204256.BadClus
      19 .iotrc.proc.20130708_204257.Secure
       0 .iotrc.proc.20130708_204258.UpCase
    7171 .iotrc.proc.20130708_204259.Extend
  335237 total
' 




##### beatles (win7 32-bit) #####
C:\
	CPCex\
	cygwin\
	Documentum\
	IzexTemp\
	MSOCache\
	mySingle\
	NVIDIA\
	PaperSecu\
-e	Program Files\
-e	ProgramData\
	SecuLog\
	Temp\
-e	Windows\
	WTablet\
	XecureSSL\
-e	Users\


##### jamiroquai (win7 64-bit) #####
C:\
	$Recycle.Bin\
	Documents and Settings\
	IDE\
	MSOCache\
	PerfLogs\
	Program Files\
	Program Files (x86)\
	ProgramData\
	Recovery\
	SymCache\
	System Volume Information\
	tracelog\
	Windows\
	wintrace\
	Users\
	hiberfil.sys	5,294,532KB
	pagefile.sys	7,059,376KB


