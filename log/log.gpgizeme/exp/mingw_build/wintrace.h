#ifndef _WINTRACE_H_
#define _WINTRACE_H_




#define THIS_PROG_NAME			"[WinTrace v1.0] Brian M. JUNG / IDM / ICL"
#define TRACE_TIME__IN_MILLI_SECOND	30000 /* 20-second */




#if 0
#define TRACE_CMD__START		"xperf -on DISK_IO+DISK_IO_INIT+FILE_IO+FILE_IO_INIT+FILENAME+PROC_THREAD"
#define TRACE_CMD__DUMP			"xperf -d iotrace.etl"
#define TRACE_CMD__TRANSFORM		"xperf -i iotrace.etl -o iotrace.log -a diskio -detail"
#else
#define TRACE_CMD__START		"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -on DISK_IO+DISK_IO_INIT+FILE_IO+FILE_IO_INIT+FILENAME+PROC_THREAD"
#define TRACE_CMD__DUMP			"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -d iotrace.log" /* <- iotrace.etl */
#define TRACE_CMD__TRANSFORM		"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -i iotrace.log -o iotrace.txt -a diskio -detail"
#define TRACE_CMD__GET_SDK		"\"c:\\program files\\internet explorer\\iexplore.exe\" http://www.microsoft.com/en-us/download/details.aspx?id=3138"
#define TRACE_CMD__INSTALL_WPT_X64	"\"c:\\program files\\microsoft sdks\\windows\\v7.0\\bin\\wpt_x64.msi\""
#define TRACE_CMD__INSTALL_WPT_X86	"\"c:\\program files\\microsoft sdks\\windows\\v7.0\\bin\\wpt_x86.msi\""
#define TRACE_CMD__INSTALL_WPT_IA64	"\"c:\\program files\\microsoft sdks\\windows\\v7.0\\bin\\wpt_ia64.msi\""
#endif




void run_cmd(LPTSTR cmd);




#endif /* _WINTRACE_H_ */
