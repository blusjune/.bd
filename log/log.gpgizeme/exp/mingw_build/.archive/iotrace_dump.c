#include <stdio.h>
#include <stdlib.h>
#include <windows.h>




#define THIS_PROG_NAME			"[WinTrace] Build#04 - Brian M. JUNG / IDM / ICL"
#define TRACE_TIME__IN_MILLI_SECOND	20000 /* 20-second */

#if 1
#define TRACE_CMD__START		"xperf -on DISK_IO+DISK_IO_INIT+FILE_IO+FILE_IO_INIT+FILENAME+PROC_THREAD"
#define TRACE_CMD__DUMP			"xperf -d iotrace.etl"
#define TRACE_CMD__TRANSFORM		"xperf -i iotrace.etl -o iotrace.log -a diskio -detail"
#else
#define TRACE_CMD__START		"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -on DISK_IO+DISK_IO_INIT+FILE_IO+FILE_IO_INIT+FILENAME+PROC_THREAD"
#define TRACE_CMD__DUMP			"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -d iotrace.etl"
#define TRACE_CMD__TRANSFORM		"\"c:\\program files\\microsoft windows performance toolkit\\xperf.exe\" -i iotrace.etl -o iotrace.log -a diskio -detail"
#endif





// void run_cmd(LPTSTR cmd, DWORD time)
void run_cmd(LPTSTR cmd)
{
	STARTUPINFOA si;
	PROCESS_INFORMATION pi;
	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	ZeroMemory(&pi, sizeof(pi));


	if (CreateProcess(NULL, cmd, NULL, NULL, FALSE, CREATE_NO_WINDOW, NULL, NULL, &si, &pi))
	{
#if 0
		WaitForSingleObject(pi.hProcess, INFINITE);
		CloseHandle(pi.hProcess);
		CloseHandle(pi.hThread);
#endif
	}
	else
	{
		char message[512];
		snprintf(message, 512, "Error code : %d", GetLastError());
		MessageBox(0, TEXT(message), cmd, MB_OK);
	}
}




int WINAPI WinMain(HINSTANCE a1, HINSTANCE a2, LPSTR a3, int a4)
{
	int answer = 0;
	answer = MessageBox(0, "Dump trace to 'iotrace.etl'", THIS_PROG_NAME, MB_YESNO);
	if (answer == IDYES)
	{

#if 0
#if 0
		run_cmd(TRACE_CMD__START);
		Sleep(TRACE_TIME__IN_MILLI_SECOND);
#endif
		run_cmd(TRACE_CMD__DUMP);
		run_cmd(TRACE_CMD__TRANSFORM);
#else
		WinExec(TRACE_CMD__DUMP, SW_HIDE);
		WinExec(TRACE_CMD__TRANSFORM, SW_HIDE);
		MessageBox(0, "Please send the iotrace.etl file to Brian M. JUNG <brian.m.jung@samsung.com>", THIS_PROG_NAME, MB_OK);
#endif
	}
	else /* answer == IDNO */
	{
#if 0
		run_cmd("\"c:\\windows\\system32\\calc.exe\"");
//		WinExec("c:\\windows\\system32\\calc.exe", SW_HIDE);
#else
		WinExec("calc", SW_HIDE);
#endif
	}

	return 0;
}
