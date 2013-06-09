#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include "wintrace.h"




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
	answer = MessageBox(0, "Click 'Yes' to dump iotrace to a file (iotrace.log)", THIS_PROG_NAME, MB_YESNO);
	if (answer == IDYES)
	{

#if 1
		run_cmd(TRACE_CMD__DUMP);
		/* seek and destroy the files called 'kernel.etl'
		 * on the first depth of directory of corresponding disk,
		 * for example, 'F:\kernel.etl' */
//		run_cmd(TRACE_CMD__TRANSFORM);
#else
		WinExec(TRACE_CMD__START, SW_HIDE);
		Sleep(TRACE_TIME__IN_MILLI_SECOND);
		WinExec(TRACE_CMD__DUMP, SW_HIDE);
		WinExec(TRACE_CMD__TRANSFORM, SW_HIDE);
#endif
	}
	else /* answer == IDNO */
	{
#if 1
		MessageBox(0, "Nothing happened, Bye.", THIS_PROG_NAME, MB_OK);
#else
//		run_cmd("\"c:\\windows\\system32\\calc.exe\"");
//		WinExec("c:\\windows\\system32\\calc.exe", SW_HIDE);
		WinExec("calc", SW_HIDE);
#endif
	}

	return 0;
}
