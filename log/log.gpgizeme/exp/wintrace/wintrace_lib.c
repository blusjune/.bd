/* char *version = "20130609_012829"; */
/* char *version = "20130610_005607"; */
/* char *version = "20130629_125908"; */




#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include "wintrace_lib.h"




int run_cmd(char * cmd, int run_cmd__exec_type)
{
	switch (run_cmd__exec_type) {
		case RUN_CMD__EXEC_TYPE__CREATEPROCESS:

			{
				STARTUPINFOA si;
				PROCESS_INFORMATION pi;
				ZeroMemory(&si, sizeof(si));
				si.cb = sizeof(si);
				ZeroMemory(&pi, sizeof(pi));
				if (CreateProcess(NULL, (LPTSTR)cmd, NULL, NULL, FALSE, CREATE_NO_WINDOW, NULL, NULL, &si, &pi))
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
					MessageBox(0, TEXT(message), (LPCTSTR)cmd, MB_OK);
				}
			}
			break;

		case RUN_CMD__EXEC_TYPE__WINEXEC:
			WinExec(cmd, SW_HIDE);
			break;

		case RUN_CMD__EXEC_TYPE__SYSTEM:
			system(cmd);
			break;

		default:
			return -1; /* abnormal exit */
	}
	return 0; /* normal exit */
}




