; ��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
#SingleInstance force

timeInterval := 300
lbtnNotFollowShift := true

#IfWinNotActive ahk_exe mstsc.exe
; Ӣ��ģʽ
~LShift:: 
	; �����ס�� shift ͨ�����ѡ��һ���ַ����л�ΪӢ�����뷨������
	state := GetKeyState("LButton")
	if ( state = 1 )
		lbtnNotFollowShift := false
return
~LShift up::	

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && lbtnNotFollowShift) {
		
		if ( WinExist("ahk_class SoPY_Comp") ) {
			Send {Enter}
		}
		
		Sleep 10
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		Sleep 10
		
		Send ^,
		
		Sleep 10
		
		Send ^+
	}
	lbtnNotFollowShift := true
return

; �л����ѹ����뷨����������ģʽ
~$RShift:: 
return
~$RShift up:: 

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		Sleep 10
		
		Send ^,
	
		Sleep 10
	
		IME_SET(1)
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
	}

return

#IfWinNotActive

#include IME.ahk