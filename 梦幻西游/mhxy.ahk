;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template AutoHotkey script.
;
#InstallKeybdHook
#UseHook
#SingleInstance force
Menu, Tray, Icon, mhxy.ico, 1, 1

; DetectHiddenWindows, On

GroupAdd, mhxy, ahk_class MHXYMainFrame
return


; $F9::
; 	if WinExist("ahk_exe mhtab.exe") {
; 	}
; 	else {
; 		send {F9}
; 	}	
; return

#IfWinActive ahk_group mhxy

XButton1 up::
	;{LMB}{WAITMS<50>}{LMB}{WAITMS<50>}{RMB}{WAITMS<50>}{RMB}{RMB}{RMB}{F1}{WAITMS<550>}{TAB}
	MouseClick, Left
	MouseClick, Right
	MouseClick, Right

	Sleep 50
	send {F1}
	Sleep 500
	send {tab}
	Sleep 500
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 xr.png
	Sleep 500
	if (ErrorLevel = 0) {
		
	} else {
		send {tab}
	}
return

WheelDown::
	if (A_PriorHotkey = "WheelDown" and A_TimeSincePriorHotkey < 400) {
	}
	else {
		send !e
	}

	sleep 2000

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 dj.png

	Sleep 500
	if (ErrorLevel = 0) {
		send !e
	}

return

WheelUp::

	WinGetActiveTitle, mhxy_title
	CoordMode, Window 
	
	if (InStr(mhxy_title, "13893793") > 0) { ; 么么静
		send !q
		send !a
		send !q
	}
	if (InStr(mhxy_title, "12001180") > 0) { ; 梦回淮水
		send !q
		send !a
		send !q
	}
	if (InStr(mhxy_title, "12918925") > 0) { ; 十月
		send !a
		send !a
	}
	if (InStr(mhxy_title, "13677799") > 0) { ; 季雅
		send !a
		send !a
	}
	if (InStr(mhxy_title, "13893810") > 0) { ; 么么轩
		send !q
		send !a
		send !q
	}
	if (InStr(mhxy_title, "13610012") > 0) { ; 卓桑君
		send !q
		send !a
		send !q
	}
return

; 连击
~<+LButton::

	
	loop {
		GetKeyState, s, LShift, P
		
		if s = U ; Button has been released, so drag is complete.
		{
			break
		}
		
		MouseClick
		sleep 100
	}

return

~<+RButton::

	
	loop {
		GetKeyState, s, LShift, P
		
		if s = U ; Button has been released, so drag is complete.
		{
			break
		}
		
		MouseClick, Right
		sleep 100
	}

return


; 回师门
~LAlt & 1::

	Send {F1}
	Sleep 200
	Send {Tab}
	Sleep 200

	WinGetActiveTitle, mhxy_title
	CoordMode, Window 
	
	if (InStr(mhxy_title, "13893793") > 0) { ; 么么静
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *TransBlack fc.png
	}
	if (InStr(mhxy_title, "13893793") > 0) { ; 梦回淮水
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *TransBlack fc.png	
	}
	if (InStr(mhxy_title, "12001180") > 0) { ; 季雅
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *TransBlack qkd.png
	}
	if (ErrorLevel = 0) {
		MouseMove FoundX, FoundY
		MouseClick
	} 
	else {
		MouseMove 404, 333
	}
	
return ; 要 return 掉，不然会继续触发其他热键

; 乾坤袋
~LAlt & 2:: ; 
	Send !R

	Sleep 200

	Send !D
	
	MouseMove FoundX, FoundX
return ;

; 师门援助
~LAlt & 3::
	if (InStr(mhxy_title, "13893793") > 0) { ; 么么静
		Send !D
		Send !A
	}
	if (InStr(mhxy_title, "13677799") > 0) { ; 季雅
		Send !A
		Send !A
	}
	
	
return ;



;~Space::MouseClick Right

; 左键+右键
`::
	MouseClick
	Sleep 100
	MouseClick, Right
	Sleep 100
	MouseClick, Right
	Sleep 100
	MouseClick, Right
return

/*
; 右键三连
Esc::
	MouseClick, Right
	Sleep 100
	MouseClick, Right
	Sleep 100
	MouseClick, Right
return
*/

; 退游弃坑
^w::
	send !{F4}
	
	CoordMode, Mouse, Window 
	ImageSearch, FoundX, FoundY, 0, 0, 1500, 1500, *TransBlack quit_game.png
	
	if ( ErrorLevel = 0 ) {
		MouseMove FoundX, FoundY
	} 
	else {
		MouseMove 234, 531
	}
	sleep 100
	MouseClick
return

global stopF5 := false
!F5::
	Loop
	{
		if stopF5
			break
		sleep 2000
		send {F5}
	}
return

^F5::
	stopF5 := true
return

!z::
	Send, !o
Return

#IfWinActive
