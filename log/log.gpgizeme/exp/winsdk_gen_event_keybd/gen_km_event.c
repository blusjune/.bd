/* wintrace_010_install_sdk_wpt.c */
/* char *version = "20130609_012829"; */
/* char *version = "20130610_005607"; */
/* char *version = "20130629_125908"; */

/*
 * References: Virtual-key codes (windows ce 5.0)
 * http://msdn.microsoft.com/en-us/library/ms927178.aspx
 *
 * VK_BACK	: Backspace key
 * VK_TAB	: Tab key
 * VK_RETURN	: Enter key
 * VK_SHIFT	: Shift key
 * VK_CONTROL	: Ctrl key
 * VK_MENU	: Alt key
 * VK_PAUSE	: Pause key
 * VK_CAPITAL	: Caps Lock key
 * VK_ESCAPE	: ESC key
 * VK_SPACE	: Space bar
 * VK_SNAPSHOT	: Print Screen key
 * VK_F1	: F1 key
 * VK_F12	: F12 key
 * VK_NUMLOCK	: Num lock key
 * VK_SCROLL	: Scroll Lock Key
 * VK_LSHIFT	: Left Shift key
 * VK_RSHIFT	: Right Shift key
 *
 */


/*
 * References: How can I simulate mouse events from code?
 * http://stackoverflow.com/questions/5164774/how-can-i-simulate-mouse-events-from-code
 *
 * #include <winuser.h>
 *
 * mouse_event(MOUSEEVENTF_MOVE | MOUSEEVENTF_ABSOLUTE, x, y, 0, 0);
 * mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
 * mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
 */




#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <winuser.h>




void SetNumLock( BOOL bState )
{

	BYTE keyState[256];
	GetKeyboardState((LPBYTE)&keyState);
	if( (bState && !(keyState[VK_NUMLOCK] & 1)) || (!bState && (keyState[VK_NUMLOCK] & 1)) )
	{
		// Simulate a key press
		keybd_event( VK_NUMLOCK, 0x45, KEYEVENTF_EXTENDEDKEY | 0, 0 );
		// Simulate a key release
		keybd_event( VK_NUMLOCK, 0x45, KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP, 0);
	}

}

void GenKBEvent( BOOL bState, int vk_code)
{

//	int vk_code = VK_ESCAPE;
	BYTE keyState[256];
	GetKeyboardState((LPBYTE)&keyState);
	if( (bState && !(keyState[vk_code] & 1)) || (!bState && (keyState[vk_code] & 1)) )
	{
		// Simulate a key press
		keybd_event( vk_code, 0x45, KEYEVENTF_EXTENDEDKEY | 0, 0 );
		// Simulate a key release
		keybd_event( vk_code, 0x45, KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP, 0);
	}

}

void main()
{
	int i = 0;
	int sleep_sec = 240; // 240: 4-minute
//	SetNumLock( TRUE );
	for (i=0; ; i++) {
		if (i%15 == 0 && i != 0) {
			printf("H");
		}
		else {
			printf(".");
		}
//		GenKBEvent( TRUE, VK_SNAPSHOT);
		mouse_event(MOUSEEVENTF_MOVE, 0, 0, 1, 1);
		sleep(sleep_sec);
	}
}




#if 0

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

#endif
