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
	answer = MessageBox(0, "This will install 'Windows Performance Toolkit' on your system\n\nIs your OS Windows 7 32-bit? then click 'Yes'\nIf not (64-bit), click 'No'", THIS_PROG_NAME, MB_YESNO);
	if (answer == IDYES)
	{ /* 32-bit */
#if 0
		run_cmd(TRACE_CMD__INSTALL_WPT_X86);
#else
//		WinExec(TRACE_CMD__INSTALL_WPT_X86, SW_HIDE);
		system(TRACE_CMD__INSTALL_WPT_X86);
#endif
	}
	else
	{ /* 64-bit */
#if 0
		run_cmd(TRACE_CMD__INSTALL_WPT_X64);
#else
//		WinExec(TRACE_CMD__INSTALL_WPT_X64, SW_HIDE);
		system(TRACE_CMD__INSTALL_WPT_X64);
#endif
	}
	return 0;
}
