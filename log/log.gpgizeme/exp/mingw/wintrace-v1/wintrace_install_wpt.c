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
	answer = MessageBox(0, "This will install 'Windows Performance Toolkit' on your system\n\nIs your OS 32-bit? then click 'Yes'\nOtherwise, click 'No' for 64-bit version", THIS_PROG_NAME, MB_YESNO);
	if (answer == IDYES)
	{ /* 32-bit */
		answer = MessageBox(0, "[Windows Performance Toolkit - INSTALLATION]\n--\nYou selected 32-bit version.\n\nClick 'Yes' to proceed.\nOr click 'No' to cancel this operation.", THIS_PROG_NAME, MB_YESNO);
		if (answer == IDYES)
		{
			system(TRACE_CMD__INSTALL_WPT_X86);
		}
		else
		{
			MessageBox(0, "Nothing happened.\n\nMany Thanks,\nBrian", THIS_PROG_NAME, MB_OK);
		}
	}
	else
	{ /* 64-bit */
		answer = MessageBox(0, "[Windows Performance Toolkit - INSTALLATION]\n--\nYou selected 64-bit version.\n\nClick 'Yes' to proceed.\nOr click 'No' to cancel this operation.", THIS_PROG_NAME, MB_YESNO);
		if (answer == IDYES)
		{
			system(TRACE_CMD__INSTALL_WPT_X64);
		}
		else
		{
			MessageBox(0, "Nothing happened.\n\nMany Thanks,\nBrian", THIS_PROG_NAME, MB_OK);
		}
	}
	return 0;
}
