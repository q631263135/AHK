; 左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
; 只保留搜狗输入法；打开 shift 中英文切换开关，在某些应用中，补偿右 shift 不能切换中文的问题
Menu, Tray, Icon, sougou.ico, 1, 1

GroupAdd, MyGroup, ahk_exe mstsc.exe

timeInterval := 300

#IfWinNotActive ahk_group MyGroup
	; 切换到搜狗输入法，设置中文模式
	~$RShift:: 
	return
	~$RShift up:: 

		if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {

			IME_SET(1)
			
			if ( GetKeyState("CapsLock", "T") ) {
				SetCapsLockState, Off
			}
			
		}
	return
#IfWinNotActive

#include IME.ahk