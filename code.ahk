Menu, Tray, Icon, Sirea-Angry-Birds-Bird-blue.ico, 1, 1

GroupAdd, 编辑器, ahk_class Notepad++
GroupAdd, 编辑器, ahk_class TPLSQLDevForm
GroupAdd, 编辑器, ahk_exe ONENOTE.EXE
GroupAdd, 编辑器, ahk_exe Typora.exe
GroupAdd, 编辑器, ahk_exe sublime_text.exe

GroupAdd, 使用英文标点, ahk_exe idea64.exe
GroupAdd, 使用英文标点, ahk_exe webstorm64.exe
GroupAdd, 使用英文标点, ahk_class TPLSQLDevForm
GroupAdd, 使用英文标点, ahk_class PX_WINDOW_CLASS
GroupAdd, 使用英文标点, ahk_exe Code.exe

GroupAdd, 浏览器, ahk_exe firefox.exe
GroupAdd, 浏览器, ahk_exe msedge.exe
GroupAdd, 浏览器, ahk_exe chrome.exe
GroupAdd, 浏览器, ahk_exe 360se.exe

GroupAdd, jetbrain, ahk_exe idea64.exe
GroupAdd, jetbrain, ahk_exe webstorm64.exe
return

; 热字符串替换
; * 不需要终止符 ?0 不在其它单词后面
:*?0:ymd::yyyy-MM-dd

::rq::
	if not WinExist("ahk_class SoPY_Comp") {
		FormatTime, currentDate, %A_Now%, yyyy-MM-dd
		send, %currentDate%
	}
return

; 编辑器 
#IfWinActive ahk_group 编辑器
	; shift + enter 下插入行
	$+Enter::
		send {End}
		send {Enter}
	return

	; alt + ctrl + enter 上插入行
	$^!Enter::
		send {Home}
		send {Enter}
		send {Up}
	return

	^+c::
	    send {Home}
		send +{End}
		send ^c
	return

	$!Backspace::
		send {del}
	return
	
#IfWinActive


; 使用英文标点 
#IfWinActive ahk_group 使用英文标点
    ~$RShift::
	return
	~$RShift Up::
		if (A_TimeSincePriorHotkey < 550 && A_Priorkey = "RShift") {
			sleep 100
        	send ^.
        }
	return
#IfWinActive


; IDEA 
#IfWinActive ahk_group jetbrain
	CapsLock & '::
		send {+}{+}
		send {shift down}{left}{left}{shift up}
		send {shift down}'{shift up}
		send {right}
		send {left}
	return

	^RButton::
		send ^/
	return

	~<^s::
		send ^{F9}
	return
	
	F2::
		send +{F6}
	return

	!d::
		send ^y
	return

	^1::
		send !{F1}
		send 1
	return

#IfWinActive


; 浏览器
#IfWinActive ahk_group 浏览器

	^r::send ^{F5}
	
	; fuck csdn
	; :z0*?:--::
	; 	send -csdn
	; 	send {enter}
	; 	send {enter}
	return

#IfWinActive


; notepad++
#IfWinActive ahk_class Notepad++
	$!w::
		send ^w
		send n
	return
#IfWinActive


;~LButton Up::SetTimer, ToolTipStatus, -200
;~Enter::SetTimer, ToolTipStatus, -200
;~CapsLock::SetTimer, ToolTipStatus, -200

ToolTipStatus() 
{
	imeMode := IME_Get()
	
	If(A_Cursor = "IBeam") {
		if (GetKeyState("CapsLock", "T")) {
			ToolTipFont("s10", "微软雅黑")
			ToolTipColor("Blue", "White")	
			ToolTip, Ａ
		} else {	
			if (imeMode = 1) {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Red", "White")
				ToolTip, 中
			} else {
				ToolTipFont("s10", "微软雅黑")
				ToolTipColor("Green", "White")
				ToolTip, Ｅ
				; ToolTip, Ｅ, A_ScreenWidth / 2, A_ScreenHeight / 2
			}
		
		}
		
		SetTimer, ToolTipOff, -800

	}
}

#include inc_plsql.ahk
#include inc_joyin_db.ahk

#include fun_ime.ahk
#include fun_tooltip.ahk