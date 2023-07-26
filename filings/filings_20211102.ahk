#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; GroupAdd 一定要放在首行位置
GroupAdd, closegroup, ahk_exe Foxmail.exe
GroupAdd, closegroup, ahk_exe TortoiseProc.exe
GroupAdd, closegroup, ahk_class WeChatMainWndForPC
GroupAdd, closegroup, ahk_class CefWebViewWnd
return

#IfWinActive ahk_group closegroup
	$^w::
		send !{F4}
	return
#IfWinActive

; D:\tools
<#t::run, explorer D:\tools

; 我的坚果云
<#j::run, explorer F:\我的坚果云

; alt + tab
RControl & RShift::AltTab 
RControl & Enter::ShiftAltTab

; 键盘光标移动
*#up::MouseMove, 0, -20, 1, R
*#Down::MouseMove, 0, 20, 1, R 
*#Left::MouseMove, -20, 0, 1, R
*#Right::MouseMove, 20, 0, 1, R

; 模拟鼠标左键
*<#RCtrl::
	SendEvent {Blind}{LButton down}
	KeyWait RCtrl  ; 防止键盘自动重复导致的重复鼠标点击
	SendEvent {Blind}{LButton up}
return

; 模拟鼠标右键
*<#RShift::
	SendEvent {Blind}{RButton down}
	KeyWait RShift
	SendEvent {Blind}{RButton up}
return

~LCtrl::
	if (A_PriorHotkey <> "~LCtrl" or A_TimeSincePriorHotkey > 300)
	{
		; Too much time between presses, so this isn't a double-press.
		; KeyWait, LCtrl
		return
	}
	WinMinimize, A
return

; 打开画图
<#p::
	KeyWait LWin
	run, https://www.processon.com/diagrams
return

; 打开狗狗搜索
<#g::
	KeyWait LWin
	run, https://www.dogedoge.com/
return

; 复制并使用狗狗搜索
<#c::
	KeyWait LWin
	Send, ^c 
	Sleep 100
	Run, https://www.dogedoge.com/results?q=%clipboard%
return

; 打开慕课网
<#y::
	KeyWait LWin
	Run, http://www.imooc.com/u/1096338/courses
return

; 账号缩写 631263135@qq.com
::/q::631263135@qq.com

; 打印当前时间
::/dd::
	d = %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%
	;clipboard = %d%
	;send ^v
	Send %d%
return

; 标点
:z0*?:,,::
	send {U+FF0C}
return

:z0*?:.,::
	send {U+3002}
return

:z0*?:\\::
	send {U+3001}
return

:b1z0*?:;;::
	send {U+FF1B}
return

:z0*?:,/::
	send ，
return

:z0*?:./::
	send 。
return

:b1z0*?:;/::
	send ；
return

; 转大写
^CapsLock::
{
	Clipboard = %clipboard% 
    Send ^{x}
    ClipWait, 2
    StringUpper, Clipboard , Clipboard
	Send ^{v}
    Return
}

; onenote 调整图片到原始大小
$~!z::
	IfWinNotActive ahk_exe ONENOTE.EXE
	{
		Send !z
	}	
	Else
	{
		MouseClick, Right
		MouseClick, Right
		send g
	}
return

; 金山 pdf
$^1::
	IfWinNotActive ahk_exe wpspdf.exe
	{
		send {Ctrl down}{LWin down}{Left}{LWin up}{Ctrl up}
	}
	Else
	{
		Send ^1
	}
return

$!e::
	IfWinActive ahk_exe wpspdf.exe
	{
		Sendplay !e
		sendplay !x
		Sendplay ^2
	}	
	Else
	{
		Send ^2
	}
return

#IfWinActive ahk_exe wpspdf.exe
$!e::
	Sendplay !e
	Sleep 200
	Sendplay !x
	Sleep 200
	Sendplay ^2
return
#IfWinActive

#IfWinActive ahk_exe explorer.exe
^k::
	send ^n
	send #{Right}
return
#IfWinActive


; 打开 Notepad++
#n:: 
IfWinNotExist ahk_class Notepad++
{
    run notepad++,,max
    WinActivate
}
Else IfWinNotActive ahk_class Notepad++
{
    WinActivate
    sleep,500
    WinMaximize,A
}
Else
{
    WinMinimize
}
Return

; 打开滴答清单
<#q::
	KeyWait LWin
	run, https://www.dida365.com/webapp/#q/all/today
return

; 标点符号
; （）
$!+9::
	keywait +
	send {U+ff08}
	send {U+ff09}{left 1}
return

; 《》
$!+,::
	keywait +
	send {U+300a}
	send {U+300b}{left 1}
return

; “”
$!+'::
	keywait +
	send {U+201c}
	send {U+201d}{left 1}
return

;【】
$!+[::
	keywait +
	send {U+3010}
	send {U+3011}{left 1}
return

; ！
$!+!::
	keywait +
	send {U+ff01}
return

; ：
$!+;::
	keywait +
	send {U+ff1a}
return

; ？
$!+/::
	keywait +
	send {U+ff1f}
return