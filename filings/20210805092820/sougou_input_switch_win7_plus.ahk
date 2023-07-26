; 左Shift强制切换到英文输入法，右Shift强制切换到中文输入法
#Include %A_ScriptDir%

timeInterval := 200
lbtnNotFollowShift := true

#IfWinNotActive ahk_exe mstsc.exe
; 英文模式
~$LShift:: 
	;解决按住左 shift 选择一串字符会切换为英文输入法的问题
	state := GetKeyState("LButton")
	if ( state = 1 )
		lbtnNotFollowShift := false
return
~$LShift up::	
	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && lbtnNotFollowShift) {
	
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}

		if ( WinExist("ahk_class SoPY_Comp") ) {
			SendInput {Enter}
		}

		SendInput ^,

		SendInput ^{Space}
		
		srf_mode := 1
	}
	
	lbtnNotFollowShift := true
	
return

; 切换到搜狗输入法，设置中文模式
~$RShift:: 
return
~$RShift up:: 


	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}

		SendInput ^,

		SendInput ^{Space}

		Sleep 50

		SendInput ^{Space}
		
		SendInput ^,
		
		srf_mode := 2
	}

return

~LButton Up::SetTimer, ToolTipStatus, -200
~CapsLock::SetTimer, ToolTipStatus, -200

global showStatus := 0
global srf_mode := 1

^!+`::
	showStatus := !showStatus
	ToolTip
return

ToolTipStatus() {
	if (showStatus)
		return

	If(A_Cursor = "IBeam") {
		if (GetKeyState("CapsLock", "T")) {
			ToolTipFont("s10", "微软雅黑")
			ToolTipColor("Blue", "White")
			ToolTip, Ａ, Caret.x, Caret.y
		} else {	
			if (srf_mode = 2) {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Red", "White")
				ToolTip, 中, Caret.x, Caret.y
			} else {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Green", "White")
				ToolTip, Ｅ, Caret.x, Caret.y
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

#IfWinNotActive ahk_exe mstsc.exe