/* wintrace_030_stop.c */
/* char *version = "20130609_012829"; */
/* char *version = "20130610_005607"; */
/* char *version = "20130629_125908"; */




#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include "wintrace_lib.h"




int WINAPI WinMain(HINSTANCE a1, HINSTANCE a2, LPSTR a3, int a4)
{
	int answer = 0;
	answer = MessageBox(0, "Click 'Yes' to stop WinTrace", THIS_PROG_NAME, MB_YESNO);
	if (answer == IDYES)
	{

		run_cmd(TRACE_CMD__STOP, RUN_CMD__EXEC_TYPE__CREATEPROCESS);
	}
	else /* answer == IDNO */
	{
		MessageBox(0, "Nothing happened.\n\nMany Thanks,\nBrian", THIS_PROG_NAME, MB_OK);
	}

	return 0;
}
