;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template AutoHotkey script.
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

RControl & RShift::AltTab  ; 按住右 control 后接着反复下右 shift 来向前移动.
RControl & Enter::ShiftAltTab  ; 甚至不需要释放右 control, 直接按 Enter 来反向移动.


Shift::SetTimer, ToolTipInputStatus_switch, -100
	
~LButton Up::
	SetTimer, ToolTipInputStatus_edit, -200
	
Return
~Enter::SetTimer, ToolTipInputStatus_edit, -200
~Up::SetTimer, ToolTipInputStatus_edit, -200
~Down::SetTimer, ToolTipInputStatus_edit, -200
~Left::SetTimer, ToolTipInputStatus_edit, -200
~Right::SetTimer, ToolTipInputStatus_edit, -200
~Backspace::SetTimer, ToolTipInputStatus_edit, -200
~CapsLock::SetTimer, ToolTipInputStatus_edit, -200


ToolTipInputStatus_switch() {
	
	srf_mode:=0
	getIMEMode := IME_Get()
	WinGet, activeexe, ProcessName, % "ahk_id" (activehwnd:=WinExist("A"))
	
	;Send {Esc}
	if (%getIMEMode% = 0) {
	
		srf_mode:=1
		
		If ((Caret:=GetCaretPos()).t="Mouse" && activeexe != "idea.exe")
			ToolTip
		Else {
			If(A_Cursor = "IBeam") {
				ToolTip, % (srf_mode&&GetKeyState("CapsLock", "T")?"Ａ":srf_mode?"中":"英"), Caret.X+5, Caret.Y+30
			}
		}
		SetTimer, ToolTipOff, -1000
		
		IME_SET(1)
		
		Send {Shift}
		
		return
	} else { 
	    
		srf_mode:=0
		
		If ((Caret:=GetCaretPos()).t="Mouse" && activeexe != "idea.exe")
			ToolTip
		Else {
			If(A_Cursor = "IBeam") {
				ToolTip, % (!(srf_mode)&&GetKeyState("CapsLock", "T")?"Ａ":srf_mode?"中":"英"), Caret.X+5, Caret.Y+30
			}
		}
		SetTimer, ToolTipOff, -1000
		IME_SET(0) 
		return 
	}
}

ToolTipInputStatus_edit() {
	srf_mode := IME_Get()
	WinGet, activeexe, ProcessName, % "ahk_id" (activehwnd:=WinExist("A"))

	If ((Caret:=GetCaretPos()).t="Mouse" && activeexe != "idea.exe")
		ToolTip
	Else {
		If(A_Cursor = "IBeam") {
			ToolTip, % (GetKeyState("CapsLock", "T")?"Ａ":srf_mode?"中":"英"), Caret.X+5, Caret.Y+30
		}
		
	}
	SetTimer, ToolTipOff, -1000
}



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
          ,  Int, 0x0005 ;wParam  : IMC_GETOPENSTATUS
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
			, NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81, IID, 8, "Int64")
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
