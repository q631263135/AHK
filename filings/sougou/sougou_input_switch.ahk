;左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
timeInterval := 500

~LShift:: ; 在按下时触发。
return

~LShift up:: ; 在弹起时触发。

	

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift") {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState,Off
		}
		
		if ( WinExist("ahk_class SoPY_Comp") ) {

			Send {Enter}
		}
		
		IME_SET(0)
		
	}
	
return


~$RShift:: ; 在按下时触发。
return

~$RShift up:: ; 在弹起时触发。

	

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock","T") ) {
			SetCapsLockState,Off
		}
		
		if ( !WinExist("ahk_class SoPY_Comp") ) {
			Send ^, ; 打开搜狗输入法
		}
		
		IME_SET(0x10000401)
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
          ,  Int, 0x006     ;wParam  : IMC_SETCONVERSIONMODE  ; 0x006 win10下使用
          ,  Int, ConvMode)  ;lParam  : CONVERSIONMODE
}