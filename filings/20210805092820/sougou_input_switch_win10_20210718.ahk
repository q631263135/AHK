; ��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
#SingleInstance force
#UseHook
#Include %A_ScriptDir%

timeInterval := 300
lbtnNotFollowShift := true

#IfWinNotActive ahk_exe mstsc.exe
; Ӣ��ģʽ
~LShift:: 
	;�����ס�� shift ѡ��һ���ַ����л�ΪӢ�����뷨������
	;state := GetKeyState("LButton")
	;if ( state = 1 )
	;	lbtnNotFollowShift := false
return
~LShift up::
	; && lbtnNotFollowShift
	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" ) {
		if ( WinExist("ahk_class SoPY_Comp") ) {
			Send {Enter}
		}

		Sleep 100
		
		IME_SET(0)
		
				
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
	}
	
return

; �л����ѹ����뷨����������ģʽ
~$RShift:: 
return
~$RShift up:: 

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		Sleep 100
		
		IME_SET(1)
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
	}

return

#IfWinNotActive

#include IME.ahk