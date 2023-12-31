;左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
timeInterval := 300

~LShift:: ; 在按下时触发。
return

~LShift up:: ; 在弹起时触发。
	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift") {
		if(GetKeyState("CapsLock","T")){
			SetCapsLockState,Off
		}
		
		IME_SET(0x10000000)
		
		if (WinExist("ahk_class SoPY_Comp"))
			Send {Enter}
		ChangeCursor()
	}
return


~$RShift:: ; 在按下时触发。
return

~$RShift up:: ; 在弹起时触发。
	
	
	;send %A_Priorkey%
	;&& A_Priorkey = "RShift" 这个控制非常重要，我弄了半天，后来也是误打误撞，尝试把 A_PriorHotkey 改成它试试，发现好使，否则，当右shift和要输入的字母一起按时，因为键程时间段，会由英文状态变为中文状态
	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift") {
		if(GetKeyState("CapsLock","T")){
			SetCapsLockState,Off
		}
		Send ^, ; 打开搜狗输入法
		
		Sleep 50
		
		IME_SET(0x10000401)
		ChangeCursor()
	}

return

CapsLock::
	KeyWait, CapsLock
	SetCapsLockState, On
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


;#If MouseIsOver("ahk_class SunAwtFrame")
~LButton Up::SetTimer, ChangeCursor, -1000

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}

ChangeCursor() {
		
	srf_mode := 0
	getIMEMode := IME_Get()

	If (getIMEMode = 0x10000401) {
		srf_mode := 1
	}
	
	if (srf_mode = 1) {
		;IDC_ARROW := 32512
		IDC_IBEAM := 32513
		
		;hCursor  := DllCall("LoadCursorFromFile", "Str", "F:\我的坚果云\软件\定制\AHK\sougou\aero_arrow_chinese.cur")
		;DllCall("SetSystemCursor", "UInt", hCursor, "Int", IDC_ARROW)
		
		hCursor  := DllCall("LoadCursorFromFile", "Str", "F:\我的坚果云\软件\定制\AHK\sougou\Wait.ani")
		DllCall("SetSystemCursor", "UInt", hCursor, "Int", IDC_IBEAM)
		
	} else {
		DllCall("SystemParametersInfo", "UInt", 0x57, "UInt", 0, "UInt", 0, "UInt", 0)
	}
	
}
