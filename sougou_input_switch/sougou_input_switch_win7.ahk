; ��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
#Include %A_ScriptDir%

timeInterval := 200
lbtnNotFollowShift := true

#IfWinNotActive ahk_exe mstsc.exe
; Ӣ��ģʽ
~$LShift:: 
	;�����ס�� shift ѡ��һ���ַ����л�ΪӢ�����뷨������
	state := GetKeyState("LButton")
	if ( state = 1 )
		lbtnNotFollowShift := false
return
~$LShift up::	
	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && lbtnNotFollowShift) {

		if ( WinExist("ahk_class SoPY_Comp") ) {
			SendInput {Enter}
		}
		Sleep 10
		
		SendInput ^,

		SendInput ^{Space}
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		lbtnNotFollowShift := true
	}
	
	
	
return

; �л����ѹ����뷨����������ģʽ
~$RShift:: 
return
~$RShift up:: 


	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {

		SendInput ^,
		Sleep 10

		SendInput ^{Space}
		Sleep 10
		
		SendInput ^{Space}
		Sleep 10
		
		SendInput ^,
				
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
	}

return

/*
; ������д
~$CapsLock::
	SetCapsLockState, On
return
*/
#IfWinNotActive ahk_exe mstsc.exe