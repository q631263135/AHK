;��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
;��Shift˫��ǿ���л����������뷨,ʹ��Ӣ�ı�����
timeInterval := 500

~LShift:: ; �ڰ���ʱ������
return

~LShift up:: ; �ڵ���ʱ������

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



~$RShift:: ; �ڰ���ʱ������
return

~$RShift up:: ; �ڵ���ʱ������

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock","T") ) {
			SetCapsLockState,Off
		}
		
		Send ^- ; ���ѹ����뷨
		
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


; Win + s Listary �Ŀ�ݼ���ʹ��Ӣ�ı��
~<#s::
	send ^.
return

; ��Ҫ shift+ �ĳɶԱ���滻Ϊ ctrl+shift+��������Ҫ�Զ����ѹ�����Щ���ΪӢ�ı��
^+9::
	send `����
	send {left}
return

^+,::
	send `����
	send {left}
return

^+'::
	send `����
	send {left}
return

^+[::
	send `����
	send {left}
return

; �Զ��滻�����ض���Ӧ���� idea ��ʹ��
:*?:,,::��
:*?:..::��
:*?:\\::��
:*?:::::��
:*?:;;::��
:*?:!!::��
:*?:??::��


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
