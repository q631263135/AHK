;左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
timeInterval := 300
hoverInterval := 200



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
		ToolTipStatus()
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
		ToolTipStatus()
	}

return

~LButton Up::SetTimer, ToolTipStatus, -200
~Enter::SetTimer, ToolTipStatus, -200
~CapsLock::SetTimer, ToolTipStatus, -200

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


global stopStatus := 0
global stopHover := 1

^+`::
stopStatus := !stopStatus
ToolTip
return

!+`::
stopHover := !stopHover
SetTimer, ToolTipOff, -1000
return


^!+`::
while(!stopHover) {
	
	Sleep hoverInterval
	
	
	;If GetKeyState("space", "P")
	;	Break
	
	WinGet, activeexe, ProcessName, % "ahk_id" (activehwnd:=WinExist("A"))
	
	If(A_Cursor = "IBeam") {
		ToolTipHover()
	}
	
	Else If (activeexe = "idea64.exe" 
			|| activeexe = "wiz.exe"
			|| activeexe = "onenote.exe" 
			|| activeexe = "EXCEL.exe" 
			|| activeexe = "VISIO.exe" 
			|| activeexe = "xmind.exe") {
		ToolTipHover()
	}
	
	Else {
		ToolTip
		Sleep 1000
	}
}

return

ToolTipHover() {
	
	srf_mode := 0
	getIMEMode := IME_Get()

	If (getIMEMode = 0x10000401) {
		srf_mode := 1
	}

	if (GetKeyState("CapsLock", "T")) {
		ToolTipFont("s10", "微软雅黑")
		ToolTipColor("Blue", "White")
		ToolTip, Ａ, Caret.x, Caret.y
	} else {	
		if (srf_mode = 1) {
			ToolTipFont("s10", "微软雅黑")
			ToolTipColor("Red", "White")
			ToolTip, 中, Caret.x, Caret.y
		} else {
			ToolTipFont("s10", "微软雅黑")
			ToolTipColor("Green", "White")
			ToolTip, Ｅ, Caret.x, Caret.y
			;ToolTip, Ｅ, A_ScreenWidth / 2, A_ScreenHeight / 2
		}
	
	}
	
	return

}

#If MouseIsOver("ahk_class SunAwtFrame")
~LButton Up::SetTimer, ToolTipStatus, -200

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}

ToolTipStatus() {
	if (!stopStatus)
		return
		
	srf_mode := 0
	getIMEMode := IME_GET()

	If (getIMEMode = 0x10000401) {
		srf_mode := 1
	}
	
	Caret := GetCaretPos()

	If(A_Cursor = "IBeam") {
		if (GetKeyState("CapsLock", "T")) {
			ToolTipFont("s10", "微软雅黑")
			ToolTipColor("Blue", "White")
			ToolTip, Ａ, Caret.x + 5, Caret.y + 30
		} else {	
			if (srf_mode = 1) {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Red", "White")
				ToolTip, 中, Caret.x + 5, Caret.y + 30
			} else {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Green", "White")
				ToolTip, Ｅ, Caret.x + 5, Caret.y + 30
				;ToolTip, Ｅ, A_ScreenWidth / 2, A_ScreenHeight / 2
			}
		
		}
		
		SetTimer, ToolTipOff, -800

	}
	
}

; 获取光标坐标
GetCaretPos(Byacc:=1){
	
    Return {x: A_CaretX, y: A_CaretY, h: 30, t: "Caret", Hwnd: Hwnd}
}

ToolTipOff:
	ToolTip
Return


ToolTipFont(Options := "", Name := "", hwnd := "") {
    static hfont := 0
    if (hwnd = "")
        hfont := Options="Default" ? 0 : _TTG("Font", Options, Name), _TTHook()
    else
        DllCall("SendMessage", "ptr", hwnd, "uint", 0x30, "ptr", hfont, "ptr", 0)
}
 
ToolTipColor(Background := "", Text := "", hwnd := "") {
    static bc := "", tc := ""
    if (hwnd = "") {
        if (Background != "")
            bc := Background="Default" ? "" : _TTG("Color", Background)
        if (Text != "")
            tc := Text="Default" ? "" : _TTG("Color", Text)
        _TTHook()
    }
    else {
        VarSetCapacity(empty, 2, 0)
        DllCall("UxTheme.dll\SetWindowTheme", "ptr", hwnd, "ptr", 0
            , "ptr", (bc != "" && tc != "") ? &empty : 0)
        if (bc != "")
            DllCall("SendMessage", "ptr", hwnd, "uint", 1043, "ptr", bc, "ptr", 0)
        if (tc != "")
            DllCall("SendMessage", "ptr", hwnd, "uint", 1044, "ptr", tc, "ptr", 0)
    }
}
 
_TTHook() {
    static hook := 0
    if !hook
        hook := DllCall("SetWindowsHookExW", "int", 4
            , "ptr", RegisterCallback("_TTWndProc"), "ptr", 0
            , "uint", DllCall("GetCurrentThreadId"), "ptr")
}
 
_TTWndProc(nCode, _wp, _lp) {
    Critical 999
   ;lParam  := NumGet(_lp+0*A_PtrSize)
   ;wParam  := NumGet(_lp+1*A_PtrSize)
    uMsg    := NumGet(_lp+2*A_PtrSize, "uint")
    hwnd    := NumGet(_lp+3*A_PtrSize)
    if (nCode >= 0 && (uMsg = 1081 || uMsg = 1036)) {
        _hack_ = ahk_id %hwnd%
        WinGetClass wclass, %_hack_%
        if (wclass = "tooltips_class32") {
            ToolTipColor(,, hwnd)
            ToolTipFont(,, hwnd)
        }
    }
    return DllCall("CallNextHookEx", "ptr", 0, "int", nCode, "ptr", _wp, "ptr", _lp, "ptr")
}
 
_TTG(Cmd, Arg1, Arg2 := "") {
    static htext := 0, hgui := 0
    if !htext {
        Gui _TTG: Add, Text, +hwndhtext
        Gui _TTG: +hwndhgui +0x40000000
    }
    Gui _TTG: %Cmd%, %Arg1%, %Arg2%
    if (Cmd = "Font") {
        GuiControl _TTG: Font, %htext%
        SendMessage 0x31, 0, 0,, ahk_id %htext%
        return ErrorLevel
    }
    if (Cmd = "Color") {
        hdc := DllCall("GetDC", "ptr", htext, "ptr")
        SendMessage 0x138, hdc, htext,, ahk_id %hgui%
        clr := DllCall("GetBkColor", "ptr", hdc, "uint")
        DllCall("ReleaseDC", "ptr", htext, "ptr", hdc)
        return clr
    }
}

