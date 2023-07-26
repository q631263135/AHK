
; 标点符号自动替换

/*
:b0z1?*:,,::
	if ( WinExist("ahk_class SoPY_Comp") )
		return
		
	ime_s := IME_GET()
	if (ime_s = 1) {
		send {bs 2}
		send {ASC 44}
	}
return

:b0z1?*:..::

	if ( WinExist("ahk_class SoPY_Comp") )
		return

	ime_s := IME_GET()
	if (ime_s = 1) {
		send {bs 2}
		send {ASC 46}
		
	}
	
return
*/


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
#IfWinNotExist

; 由shift + 符号输出的中文标点统一为 alt + shift 输出，原来的功能输出为英文标点
; http://tool.chinaz.com/tools/unicode.aspx
; http://ahkcn.sourceforge.net/docs/Hotstrings.htm

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