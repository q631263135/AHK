;左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
;左Shift双击强制切换到中文输入法,使用英文标点符号
timeInterval := 500

~LShift:: ; 在按下时触发。
return

~LShift up:: ; 在弹起时触发。

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift") {
		if ( GetKeyState("CapsLock","T") ) {
			SetCapsLockState,Off
		}
		
		IME_SET(0x10000000)
		
		if ( WinExist("ahk_class SoPY_Comp") ) {
			Send {Enter}
		}
	}
	
return



~$RShift:: ; 在按下时触发。
return

~$RShift up:: ; 在弹起时触发。

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock","T") ) {
			SetCapsLockState,Off
		}
		
		Send ^- ; 打开搜狗输入法
		
		IME_SET(0x10000401)
		
		WinGet, activeexe, ProcessName, % "ahk_id" (activehwnd := WinExist("A"))
		if ( activeexe = "idea64.exe" || activeexe = "idea.exe" ) {
			Send ^.
		}
	}

return

IME_GET(WinTitle="A") {
    ControlGet,hwnd,HWND,,,%WinTitle%
    if  (WinActive(WinTitle))   {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize := 4 + 4 + (PtrSize * 6) + 16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")  ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint, 0, Uint,  & stGTI)
                 ? NumGet(stGTI, 8 + PtrSize, "UInt") : hwnd
    }

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283 ;Message : WM_IME_CONTROL
          ,  Int, 0x001 ;wParam  : IMC_GETOPENSTATUS
          ,  Int, 0)     ;lParam  : 0
}

IME_SET(ConvMode,WinTitle="A") {
    ControlGet,hwnd,HWND,,,%WinTitle%
    if  (WinActive(WinTitle))   {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize := 4 + 4 + (PtrSize * 6) + 16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")  ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint, 0, Uint,  & stGTI)
                 ? NumGet(stGTI, 8 + PtrSize, "UInt") : hwnd
    }
    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283     ;Message : WM_IME_CONTROL
          ,  Int, 0x002      ;wParam  : IMC_SETCONVERSIONMODE
          ,  Int, ConvMode)  ;lParam  : CONVERSIONMODE
}


; Win + s Listary 的快捷键，使用英文标点
~<#s::
	send ^.
return

; 需要 shift+ 的成对标点替换为 ctrl+shift+触发，需要自定义搜狗的这些标点为英文标点
^+9::
	send `（）
	send {left}
return

^+,::
	send `《》
	send {left}
return

^+'::
	send `“”
	send {left}
return

^+[::
	send `【】
	send {left}
return

; 自动替换，在特定的应用如 idea 中使用
:*?:,,::，
:*?:..::。
:*?:\\::、
:*?:::::：
:*?:;;::；
:*?:!!::！
:*?:??::？


/*
~Backspace::
	if (A_TimeSincePriorHotkey < 3000) {
		if (A_Priorkey = chr(46)) {
			sendinput {ASC 46}
		}
		else if (A_Priorkey = chr(58)) {
			IME_SET(0x10000000)
			send `:
		}

		else if (A_Priorkey = chr(59)) {
			; IME_SET(0x10000000)
			send {ASC 59}
		}
		else if (A_Priorkey = "/") {
			IME_SET(0x10000000)
			send `?
		}
	}
return
*/
