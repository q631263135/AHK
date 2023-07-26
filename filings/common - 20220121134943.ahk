; 光标下移
CapsLock & j::
	send {Down}
return

; 光标上移
CapsLock & k::
	send {Up}
return

; 光标左移，如果同时按住 Alt 键，移动到行首
CapsLock & h::
	if GetKeyState("alt") != 0 
		send {Home}
	else if GetKeyState("ctrl") != 0
		send ^{Left}
	else if GetKeyState("shift") != 0
		send +{Left}
	else
		send {Left}
return

; 光标右移，如果同时按住 Alt 键，移动到行尾
CapsLock & l::
	if GetKeyState("alt") != 0 
		send {End}
	else if GetKeyState("ctrl") != 0
		send ^{Right}
	else if GetKeyState("shift") != 0
		send +{Right}
	else
		send {Right}
return

; 打开计算器
::/cc::
	IfWinNotExist ahk_class CalcFrame
	{
	  Run calc.exe
	  WinActivate
	}
	Else IfWinNotActive ahk_class CalcFrame
	{
	  WinActivate
	}
Return

; 打开画图
::/pp::
IfWinNotExist ahk_class MSPaintApp
{
  Run mspaint.exe
  WinActivate
}
Return

; 关闭所有资源管理器
$<#w::
    GroupAdd, Explore, ahk_class CabinetWClass
    GroupClose, Explore, A
return

; 中文标点替换为英文
#IfWinNotExist ahk_class SoPY_Comp
:z0*?:,,::
	send {ASC 44}
return

:z0*?:..::
	send {ASC 46}
return

:z0*?:\\::
	send {ASC 92}
return

:b1z0*?:;;::
	send {ASC 59}
return

:b1z0*?:__::
	send {BS}
	send {ASC 95}
return

:z0*?:??::
	send {ASC 63}
return

:z0*?:::::
	send {ASC 58}
return

:z0*?:!!::
	send {ASC 33}
return

/*
:z0*?:<<::
	send {ASC 60}
	send {ASC 62}{left 1}
return

:z0*?:[[::
	send {ASC 91}
	send {ASC 93}{left 1}
return
*/

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
#IfWinNotExist