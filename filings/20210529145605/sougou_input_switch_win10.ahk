; 左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
#SingleInstance force
#UseHook
#Include %A_ScriptDir%

timeInterval := 300
lbtnNotFollowShift := true

#IfWinNotActive ahk_exe mstsc.exe
; 英文模式
~LShift:: 
	;解决按住左 shift 选择一串字符会切换为英文输入法的问题
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

; 切换到搜狗输入法，设置中文模式
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