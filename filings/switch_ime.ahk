#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
switchIME(layout) 
{
  HKL := DllCall("LoadKeyboardLayout", Str, layout, UInt, 1)
  ControlGetFocus, ctl, A
  SendMessage, 0x50, 0, HKL, %ctl%, A
}


timeInterval := 200
lbtnNotFollowShift := true

#IfWinNotActive ahk_exe mstsc.exe
; 英文模式
~$LShift:: 
	;解决按住左 shift 选择一串字符会切换为英文输入法的问题
	state := GetKeyState("LButton")
	if ( state = 1 )
		lbtnNotFollowShift := false
return
~$LShift up::	
	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && lbtnNotFollowShift) {
	
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}

		if ( WinExist("ahk_class SoPY_Comp") ) {
			SendInput {Enter}
		}

		switchIME(04090409)
	}
	
	lbtnNotFollowShift := true
	
return

; 切换到搜狗输入法，设置中文模式
~$RShift:: 
return
~$RShift up:: 


	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		switchIME(1)
	}

return
#IfWinNotActive ahk_exe mstsc.exe