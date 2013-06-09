#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

// int WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
int WINAPI WinMain(HINSTANCE a1, HINSTANCE a2, LPSTR a3, int a4)
{
	int answer = 0;
//	MessageBox(0, "Hello, Windows", "MinGW Test Program", MB_OK);
	answer = MessageBox(0, "[WinTrace] Ready to run wintrace?", "Blame to Brian M. JUNG <brian.m.jung@samsung.com>", MB_YESNO);
	if (answer == IDYES)
	{
		system("xperf -on DISK_IO+DISK_IO_INIT+FILE_IO+FILE_IO_INIT+FILENAME+PROC_THREAD");
		Sleep(10000);
		system("xperf -d iotrace.etl");
//		system("xperf -i iotrace.etl -o iotrace.log -a diskio -detail");
	}
	else /* answer == IDNO */
	{
		system("iexplorer");
	}

	return 0;
}
