; ��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
; ֻ�����ѹ����뷨���� shift ��Ӣ���л����أ���ĳЩӦ���У������� shift �����л����ĵ�����
Menu, Tray, Icon, sougou.ico, 1, 1

GroupAdd, MyGroup, ahk_exe mstsc.exe

timeInterval := 300

#IfWinNotActive ahk_group MyGroup
	; �л����ѹ����뷨����������ģʽ
	~$RShift:: 
	return
	~$RShift up:: 

		if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {

			IME_SET(1)
			
			if ( GetKeyState("CapsLock", "T") ) {
				SetCapsLockState, Off
			}
			
		}
	return
#IfWinNotActive

#include IME.ahk