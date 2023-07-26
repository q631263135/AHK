;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template AutoHotkey script.
;
;窗口切换
RControl & RShift::AltTab  ; 按住右 control 后接着反复下右 shift 来向前移动.
RControl & Enter::ShiftAltTab  ; 甚至不需要释放右 control, 直接按 Enter 来反向移动.

;打开 chrome
#c::Run chrome


;打开 微信
#w::Run "C:\Program Files (x86)\Tencent\WeChat\WeChat.exe"


;输入法状态
Shift::SetTimer, ToolTipInputStatus, -100
~LButton Up::SetTimer, ToolTipInputStatus, -200
~Enter::SetTimer, ToolTipInputStatus, -200
;~Up::SetTimer, ToolTipInputStatus, -200
;~Down::SetTimer, ToolTipInputStatus, -200
;~Left::SetTimer, ToolTipInputStatus, -200
;~Right::SetTimer, ToolTipInputStatus, -200
;~Backspace::SetTimer, ToolTipInputStatus, -200
~CapsLock::SetTimer, ToolTipInputStatus, -200

ToolTipInputStatus() {
	
	srf_mode:=0
	getIMEMode := IME_Get()
	WinGet, activeexe, ProcessName, % "ahk_id" (activehwnd:=WinExist("A"))
	
	If (getIMEMode = 268436489 || getIMEMode = 1025 || getIMEMode = 268436481) {
		srf_mode:=1
	}
	
	If ((Caret:=GetCaretPos()).t="Mouse" && activeexe != "idea64.exe" && activeexe != "idea.exe" && activeexe != "Wiz.exe") {
		ToolTip
	} Else {
		If (activeexe = "idea.exe" || activeexe = "idea64.exe" || activeexe = "Wiz.exe") {
			If(A_Cursor = "IBeam" || A_Cursor = "Unknown") {
				if (GetKeyState("CapsLock", "T")) {
					ToolTipFont("s35", "微软雅黑")
					ToolTipColor("Blue", "White")
					ToolTip, Ａ, 9999, 800
				} else {
					if (srf_mode = 1) {
						ToolTipFont("s35", "微软雅黑")
						ToolTipColor("Red", "White")
						ToolTip, 中, 9999, 800
					} else {
						ToolTipFont("s35", "微软雅黑")
						ToolTipColor("Green", "White")
						ToolTip, Ｅ, 9999, 800
					}
				
				}
			}
			
		} Else if (A_Cursor = "IBeam") {
			
			if (GetKeyState("CapsLock", "T")) {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Blue", "White")
				ToolTip, Ａ, Caret.x+5, Caret.y+30
			} else {
				if (srf_mode = 1) {
					ToolTipFont("s10", "微软雅黑")
					ToolTipColor("Red", "White")
					ToolTip, 中, Caret.x+5, Caret.y+30
				} else {
					ToolTipFont("s10", "微软雅黑")
					ToolTipColor("Green", "White")
					ToolTip, Ｅ, Caret.x+5, Caret.y+30
				}
			
			}
			
		}
		
		SetTimer, ToolTipOff, -1100
	}
	
	return 
}

^+`::
loop {
	Sleep, 300
	WinGet, activeexe, ProcessName, % "ahk_id" (activehwnd:=WinExist("A"))
	If (activeexe == "idea64.exe") {
	
		srf_mode:=0
		getIMEMode := IME_Get()

		;Send %getIMEMode%
		If (getIMEMode = 268436489 || getIMEMode = 1025 || getIMEMode = 268436481) {
			srf_mode:=1
		} Else { 
			srf_mode:=0
		}
	
		ToolTip, % (GetKeyState("CapsLock", "T")?"Ａ":srf_mode?"中":"Ｅ"), Caret.X+5, Caret.Y+30
	}
	
}
return


ToolTipOff:
	ToolTip
Return

IME_GET(WinTitle="A")  {
    ControlGet,hwnd,HWND,,,%WinTitle%
    if  (WinActive(WinTitle))   {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")  ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
    }

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283 ;Message : WM_IME_CONTROL
          ,  Int, 0x001 ;wParam  : IMC_GETOPENSTATUS
          ,  Int, 0)     ;lParam  : 0
}

IME_SET(SetSts, WinTitle="A")    {
    ControlGet,hwnd,HWND,,,%WinTitle%
    if  (WinActive(WinTitle))   {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")  ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
    }

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283 ;Message : WM_IME_CONTROL
          ,  Int, 0x006  ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}

; 获取光标坐标
GetCaretPos(Byacc:=1){
	Static init
    If (A_CaretX=""){
		Caretx:=Carety:=CaretH:=CaretW:=0
		If (Byacc){
			If (!init)
				init:=DllCall("LoadLibrary","Str","oleacc","Ptr")
			VarSetCapacity(IID,16), idObject:=OBJID_CARET:=0xFFFFFFF8
			, NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0, IID, "Int64")
			, NumPut(idObject==0xFFFFFFF0?0x48000000000000C0:0x719B3800AA000C81, IID, 8, "Int64")
			If (DllCall("oleacc\AccessibleObjectFromWindow", "Ptr",Hwnd:=WinExist("A"), "UInt",idObject, "Ptr",&IID, "Ptr*",pacc)=0){
				Acc:=ComObject(9,pacc,1), ObjAddRef(pacc)
				Try Acc.accLocation(ComObj(0x4003,&x:=0), ComObj(0x4003,&y:=0), ComObj(0x4003,&w:=0), ComObj(0x4003,&h:=0), ChildId:=0)
				, CaretX:=NumGet(x,0,"int"), CaretY:=NumGet(y,0,"int"), CaretH:=NumGet(h,0,"int")
			}
		}
		If (Caretx=0&&Carety=0){
			MouseGetPos, x, y
			Return {x:x,y:y,h:30,t:"Mouse",Hwnd:Hwnd}
		} Else
        	Return {x:Caretx,y:Carety,h:Max(Careth,30),t:"Acc",Hwnd:Hwnd}
    } Else
        Return {x:A_CaretX,y:A_CaretY,h:30,t:"Caret",Hwnd:Hwnd}
}

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
