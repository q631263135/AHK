; ��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
#SingleInstance force
#UseHook
#Include %A_ScriptDir%

timeInterval := 500

; Ӣ��ģʽ
~LShift:: 
return
~LShift up::

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift") {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState,Off
		}
		
		if ( WinExist("ahk_class SoPY_Comp") ) {
			Send {Enter}
		}
		
		send ^{Space}
	}
	
return

; �л����ѹ����뷨����������ģʽ
~$RShift:: 
return
~$RShift up:: 


	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState,Off
		}
		
		if ( !WinExist("ahk_class SoPY_Comp") ) {
			send ^{Space}
			send {Ctrl}
		}
		
		IME_SET(1)
		
	}

return

#include IME.ahk
#include replace_punctuation.ahk