;��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
timeInterval := 300

~LShift:: ; �ڰ���ʱ������
return

~LShift up:: ; �ڵ���ʱ������
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


~$RShift:: ; �ڰ���ʱ������
return

~$RShift up:: ; �ڵ���ʱ������
	
	
	;send %A_Priorkey%
	;&& A_Priorkey = "RShift" ������Ʒǳ���Ҫ����Ū�˰��죬����Ҳ�������ײ�����԰� A_PriorHotkey �ĳ������ԣ����ֺ�ʹ�����򣬵���shift��Ҫ�������ĸһ��ʱ����Ϊ����ʱ��Σ�����Ӣ��״̬��Ϊ����״̬
	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift") {
		if(GetKeyState("CapsLock","T")){
			SetCapsLockState,Off
		}
		Send ^, ; ���ѹ����뷨
		
		Sleep 50
		
		IME_SET(0x10000401)
		
		ChangeCursor()
	}

return

; ��������д
;CapsLock::
;	KeyWait, CapsLock
;	SetCapsLockState, On
;return

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
		
		;hCursor  := DllCall("LoadCursorFromFile", "Str", "F:\�ҵļ����\���\����\AHK\sougou\aero_arrow_chinese.cur")
		;DllCall("SetSystemCursor", "UInt", hCursor, "Int", IDC_ARROW)
		
		hCursor  := DllCall("LoadCursorFromFile", "Str", "beam_chinese.cur")
		DllCall("SetSystemCursor", "UInt", hCursor, "Int", IDC_IBEAM)
		
	} else {
		DllCall("SystemParametersInfo", "UInt", 0x57, "UInt", 0, "UInt", 0, "UInt", 0)
	}
	
}
