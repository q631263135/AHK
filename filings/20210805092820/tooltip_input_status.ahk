~LButton Up::ToolTipStatus()
~CapsLock::ToolTipStatus()

global stopStatus := 0

^+`::
	stopStatus := !stopStatus
	ToolTip
return

ToolTipStatus() {
	If (!stopStatus)
		return
		
	srf_mode := 1
	getIMEMode := IME_GET()

	If (getIMEMode = 0) {
		srf_mode := 0
	}
	
	Caret := GetCaretPos()

	If(A_Cursor = "IBeam") {
		if (GetKeyState("CapsLock", "T")) {
			ToolTipFont("s10", "微软雅黑")
			ToolTipColor("Blue", "White")
			ToolTip, Ａ, Caret.x + 5, Caret.y + 30
			;ToolTip, Ａ, A_ScreenWidth * 3 / 5, A_ScreenHeight * 4 / 5
		} else {	
			if (srf_mode = 1) {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Red", "White")
				ToolTip, 中, Caret.x + 5, Caret.y + 30
				;ToolTip, 中, A_ScreenWidth * 3 / 5, A_ScreenHeight * 4 / 5
			} else {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Green", "White")
				ToolTip, Ｅ, Caret.x + 5, Caret.y + 30
				;ToolTip, Ｅ, A_ScreenWidth * 3 / 5, A_ScreenHeight * 4 / 5
			}
		
		}
		
		SetTimer, ToolTipOff, -900

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

IME_GET(WinTitle="A")  {
    hwnd := GetGUIThreadInfo_hwndActive(WinTitle)
    return DllCall("SendMessage"
          , Ptr, DllCall("imm32\ImmGetDefaultIMEWnd", Ptr,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          , UPtr, 0x005   ;wParam  : IMC_GETOPENSTATUS0
          ,  Ptr, 0)      ;lParam  : 0
}

GetGUIThreadInfo_hwndActive(WinTitle="A")
{
	ControlGet, hwnd, HWND,,, %WinTitle%
	if (WinActive(WinTitle)) {
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
		VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
		NumPut(cbSize, stGTI,  0, "UInt")
		return hwnd := DllCall("GetGUIThreadInfo", "Uint", 0, "Ptr", &stGTI)
				 ? NumGet(stGTI, 8+PtrSize, "Ptr") : hwnd
	}
	else {
		return hwnd
	}
}
