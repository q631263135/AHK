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
	state := GetKeyState("LButton")
	if ( state = 1 )
		lbtnNotFollowShift := false
return
~LShift up::
	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && lbtnNotFollowShift) {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		if ( WinExist("ahk_class SoPY_Comp") ) {
			SendPlay {Enter}
		}
		
		sleep 100
		switchime(0)
	}
	
return

; �л����ѹ����뷨����������ģʽ
~$RShift:: 
return
~$RShift up:: 

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		switchime(1)
	}

return


#IfWinNotActive

switchime(ime := "A") {
	if (ime = 1) {
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"00000804", UInt, 1))
	}
	else if (ime = 0) {
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
	}
	else if (ime = "A") {
		;ime_status:=DllCall("GetKeyboardLayout","int",0,UInt)
		Send, #{Space}
	}
}