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
		/* 使用搜狗自己的上屏功能
		if ( WinExist("ahk_class SoPY_Comp") ) {
			Send {Enter}
		}
		*/
		
		Sleep 10
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		Sleep 10
		
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
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
		
		Sleep 10
		
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
	
		Sleep 10
		
		Send ^,
		
		Sleep 10
		
		Send ^{Space} ; 如果游戏里不好用，把这里改成 Send +  ，然后开启输入法的 shift 切换状态功能，利用 输入法的快捷键实现切换
		; Send {Shift}
	}

return

#IfWinNotActive