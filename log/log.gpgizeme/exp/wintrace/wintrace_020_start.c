/* wintrace_020_start.c */
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
	answer_1 = MessageBox(0, "Ready to start WinTrace? (then click 'Yes')\n", THIS_PROG_NAME, MB_YESNO);
//	answer_1 = MessageBox(0, "Ready to start WinTrace? (then click 'Yes')\n\n--\n[Prerequisites to exec WinTrace]\n(1) 'Microsoft Windows SDK'\n(2) 'Microsoft Windows Performance Toolkit'", THIS_PROG_NAME, MB_YESNO);
//
	if (answer_1 == IDYES)
	{

		run_cmd(TRACE_CMD__START, RUN_CMD__EXEC_TYPE__CREATEPROCESS);
	#if 0
		Sleep(TRACE_TIME__IN_MILLI_SECOND);
		run_cmd(TRACE_CMD__DUMP, RUN_CMD__EXEC_TYPE__CREATEPROCESS);
		run_cmd(TRACE_CMD__TRANSFORM, RUN_CMD__EXEC_TYPE__CREATEPROCESS);
	#endif
	}
	else /* answer_1 == IDNO */
	{
		MessageBox(0, "Nothing happened.\n\nMany Thanks,\nBrian", THIS_PROG_NAME, MB_OK);
	}

	return 0;
}




