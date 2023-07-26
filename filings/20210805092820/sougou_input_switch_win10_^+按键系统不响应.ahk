; 左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
#SingleInstance force

timeInterval := 300
lbtnNotFollowShift := true

#IfWinNotActive ahk_exe mstsc.exe
; 英文模式
~LShift:: 
	; 解决按住左 shift 通过鼠标选择一串字符会切换为英文输入法的问题
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

; 切换到搜狗输入法，设置中文模式
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