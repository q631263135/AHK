; 左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
#Include %A_ScriptDir%

timeInterval := 500

; 英文模式
~$LShift:: 
return
~$LShift up::

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift") {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		if ( WinExist("ahk_class SoPY_Comp") ) {
			Send {Enter}
		}
		
		;Sleep 100 ; 让搜狗先切换，然后强制改为英文
		
		;ime_status := IME_GetConvMode()
		
		;send %ime_status%
		
		;在 2020-7-15 突然就不好用了，即便 ime_status 输出的是 0，但输入法依然是中文模式
		
		IME_SetConvMode(0)
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
		
		if ( !WinExist("ahk_class SoPY_Comp") ) {
			Send ^,
		}
		
		; Sleep 300 ; 让搜狗先切换，然后强制改为中文
		
		IME_SetConvMode(1025) ; 0x10000401
	}

return

#include IME.ahk
#include replace_punctuation.ahk