; 左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
#SingleInstance force
#UseHook
#Include %A_ScriptDir%

timeInterval := 500

; 英文模式
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

; 切换到搜狗输入法，设置中文模式
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