;��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
timeInterval := 500

~LShift:: ; �ڰ���ʱ������
return

~LShift up:: ; �ڵ���ʱ������

	

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


~$RShift:: ; �ڰ���ʱ������
return

~$RShift up:: ; �ڵ���ʱ������

	

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock","T") ) {
			SetCapsLockState,Off
		}
		
		if ( !WinExist("ahk_class SoPY_Comp") ) {
			Send ^, ; ���ѹ����뷨
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
          ,  Int, 0x006     ;wParam  : IMC_SETCONVERSIONMODE  ; 0x006 win10��ʹ��
          ,  Int, ConvMode)  ;lParam  : CONVERSIONMODE
}