;��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
;��Shift˫��ǿ���л����������뷨,ʹ��Ӣ�ı�����
timeInterval := 500
counter := 0
presshold := ""
;global a_prior_prior_key

~LShift:: ; �ڰ���ʱ������

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift") 
	{
		counter = 0
		GetKeyState, s, LShift, P
		presshold = %presshold%%s%
	} 
	else 
	{
		counter = 1
		a_prior_prior_key = %A_Priorkey%
	}
return

~LShift up:: ; �ڵ���ʱ������

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && counter = 1) 
	{
		if(GetKeyState("CapsLock","T"))
		{
			SetCapsLockState,Off
		}
		
		IME_SET(0x10000000)
		
		if (WinExist("ahk_class SoPY_Comp"))
			Send {Enter}
	} 
	else if (A_Priorkey = "LShift" && counter = 0)
	{
		if (presshold = "D") {
			IME_SET(0x10000401)
			Send ^.
		}
	}
	presshold := ""
	
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

~Backspace::
	if (A_TimeSincePriorHotkey < 3000) {
		if (A_Priorkey = chr(46)) {
			IME_SET(0x10000000)
			send `.
		}
		else if (A_Priorkey = chr(58)) {
			IME_SET(0x10000000)
			send `:
		}

		else if (A_Priorkey = chr(59)) {
			IME_SET(0x10000000)
			send `;
		}
		else if (A_Priorkey = "/") {
			IME_SET(0x10000000)
			send `?
		}
	}
return
