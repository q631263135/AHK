; 左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
#Include %A_ScriptDir%

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

; 切换到搜狗输入法，设置中文模式
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
; 锁定大写
~$CapsLock::
	SetCapsLockState, On
return
*/
#IfWinNotActive ahk_exe mstsc.exe