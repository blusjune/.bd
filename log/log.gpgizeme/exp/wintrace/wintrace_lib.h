/* wintrace_lib.h */
/* char *version = "20130609_012829"; */
/* char *version = "20130610_005607"; */
/* char *version = "20130629_125908"; */




#ifndef _WINTRACE_LIB_H_
#define _WINTRACE_LIB_H_




/*
 * #define THIS_PROG_NAME			"[WinTrace v1.1] Brian M. JUNG / IDM / ICL"
 * */
#define THIS_PROG_NAME			"[WinTrace v1.2] Brian M. JUNG / IDM / ICL"
#define TRACE_TIME__IN_MILLI_SECOND	30000 /* 20-second */




#define RUN_CMD__EXEC_TYPE__SYSTEM		1
#define RUN_CMD__EXEC_TYPE__WINEXEC		2
#define RUN_CMD__EXEC_TYPE__CREATEPROCESS	3
#define RUN_CMD__EXEC_TYPE			RUN_CMD__EXEC_TYPE__CREATEPROCESS




/* #define TRACE_CMD__START		"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -on DISK_IO+DISK_IO_INIT+FILE_IO+FILE_IO_INIT+FILENAME+PROC_THREAD -f ktrace_buf.tmp" */
#define TRACE_CMD__START		"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -on DISK_IO+DISK_IO_INIT+FILE_IO+FILE_IO_INIT+FILENAME+PROC_THREAD -f iotrace.log"
#define TRACE_CMD__STOP			"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -stop"
#define TRACE_CMD__DUMP			"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -d iotrace.log" /* <- iotrace.etl */
#define TRACE_CMD__TRANSFORM		"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -i iotrace.log -o iotrace.txt -a diskio -detail"
#define TRACE_CMD__GET_SDK		"\"c:\\program files\\internet explorer\\iexplore.exe\" http://www.microsoft.com/en-us/download/details.aspx?id=3138"
#define TRACE_CMD__INSTALL_WPT_X64	"\"c:\\program files\\microsoft sdks\\windows\\v7.0\\bin\\wpt_x64.msi\""
#define TRACE_CMD__INSTALL_WPT_X86	"\"c:\\program files\\microsoft sdks\\windows\\v7.0\\bin\\wpt_x86.msi\""
#define TRACE_CMD__INSTALL_WPT_IA64	"\"c:\\program files\\microsoft sdks\\windows\\v7.0\\bin\\wpt_ia64.msi\""
#define MS_WINDOWS_SDK_BIN_DIR		"\"c:\\program files\\microsoft sdks\\windows\\v7.0\\bin\""




#if 0 /* only for winexec() */
#define TRACE_CMD__START		"xperf -on DISK_IO+DISK_IO_INIT+FILE_IO+FILE_IO_INIT+FILENAME+PROC_THREAD"
#define TRACE_CMD__DUMP			"xperf -d iotrace.etl"
#define TRACE_CMD__TRANSFORM		"xperf -i iotrace.etl -o iotrace.log -a diskio -detail"
#endif




int run_cmd(char * cmd, int run_cmd__exec_type);




#endif /* _WINTRACE_LIB_H_ */
