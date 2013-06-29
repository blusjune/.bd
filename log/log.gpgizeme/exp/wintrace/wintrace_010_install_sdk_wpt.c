/* wintrace_010_install_sdk_wpt.c */
/* char *version = "20130609_012829"; */
/* char *version = "20130610_005607"; */
/* char *version = "20130629_125908"; */




#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include "wintrace_lib.h"




int WINAPI WinMain(HINSTANCE a1, HINSTANCE a2, LPSTR a3, int a4)
{
	int answer_1 = 0;
	int answer_2 = 0;

	answer_1 = MessageBox(0, "This will install\n(1) Microsoft Windows 'SDK'\n(2) Microsoft Windows 'Performance Toolkit'\n\nClick 'Yes' to proceed, or click 'No' to cancel", THIS_PROG_NAME, MB_YESNO);
	if (answer_1 == IDYES)
	{
		MessageBox(0, "[ STEP 1: SDK Installation ]\n\nNew browser window will be launched opening 'SDK download page.'\nPlease download/execute 'winsdk_web.exe' file to install the SDK.\n\nNOTE:\nAfter SDK installation is completed well,\nplease close(terminate) the 'SDK download page' window (if not closed yet)\nto go to the next installation step", THIS_PROG_NAME, MB_OK);
		run_cmd(TRACE_CMD__GET_SDK, RUN_CMD__EXEC_TYPE__SYSTEM);
	}
	else
	{
		MessageBox(0, "Nothing happened.\n\nMany Thanks,\nBrian", THIS_PROG_NAME, MB_OK);
		return 0;
	}


#if 0
	/*
	 * check whether SDK is installed successfully or not,
	 * by test whether some WPT installation file exists or not
	 */
	{
		DWORD retval = 0;
		retval = GetFileAttributes(MS_WINDOWS_SDK_BIN_DIR);
		if (retval == INVALID_FILE_ATTRIBUTES)
		{
			DWORD errcode = GetLastError();
			switch (errcode) {
				case ERROR_FILE_NOT_FOUND:
				case ERROR_PATH_NOT_FOUND:
					MessageBox(0, "ERROR\n\n'Microsoft Windows SDK' might not be installed properly.\nCannot proceed installation process any further.\nPlease contact the author (Brian M. JUNG <brian.m.jung@samsung.com>)\n", THIS_PROG_NAME, MB_OK);
					break;
				case ERROR_ACCESS_DENIED:
					MessageBox(0, "ERROR\n\nCould not access SDK file.\nCannot proceed installation process any further.\nPlease contact the author (Brian M. JUNG <brian.m.jung@samsung.com>)\n", THIS_PROG_NAME, MB_OK);
					break;
				default:
					MessageBox(0, "ERROR\n\nUnknown error occurred.\nCannot proceed installation process any further.\nPlease contact the author (Brian M. JUNG <brian.m.jung@samsung.com>)\n", THIS_PROG_NAME, MB_OK);
			}
			return -1;
		}
		else
		{
			MessageBox(0, "Good!\nSeems 'Microsoft Windows SDK' installed properly.\n", THIS_PROG_NAME, MB_OK);
		}
	}
#endif


	answer_2 = MessageBox(0, "[ STEP 2: Performance Toolkit Installation ]\n\nIs your OS 32-bit? then click 'Yes'\nIf 64-bit, then click 'No'", THIS_PROG_NAME, MB_YESNO);
	if (answer_2 == IDYES)
	{ /* 32-bit */
		int answer_3 = 0;
		answer_3 = MessageBox(0, "You selected 32-bit version.\n\nClick 'Yes' to proceed.\nOr click 'No' to cancel this operation.", THIS_PROG_NAME, MB_YESNO);
		if (answer_3 == IDYES)
		{
			run_cmd(TRACE_CMD__INSTALL_WPT_X86, RUN_CMD__EXEC_TYPE__SYSTEM);
			// system(TRACE_CMD__INSTALL_WPT_X86);
		}
		else
		{
			MessageBox(0, "Nothing happened.\n\nMany Thanks,\nBrian", THIS_PROG_NAME, MB_OK);
		}
	}
	else
	{ /* 64-bit */
		int answer_3 = 0;
		answer_3 = MessageBox(0, "You selected 64-bit version.\n\nClick 'Yes' to proceed.\nOr click 'No' to cancel this operation.", THIS_PROG_NAME, MB_YESNO);
		if (answer_3 == IDYES)
		{
			run_cmd(TRACE_CMD__INSTALL_WPT_X64, RUN_CMD__EXEC_TYPE__SYSTEM);
			// system(TRACE_CMD__INSTALL_WPT_X64);
		}
		else
		{
			MessageBox(0, "Nothing happened.\n\nMany Thanks,\nBrian", THIS_PROG_NAME, MB_OK);
		}
	}
	return 0;
}
