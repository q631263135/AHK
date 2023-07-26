; 标点符号自动替换
:z0*?:,,::
	ime_s := IME_GET()
	if (ime_s = 1) {
		send {ASC 44}
	}
	else {
		send {ASC 44}
		send {ASC 44}
	}
return

:z0*?:..::
	ime_s := IME_GET()
	if (ime_s = 1) {
		send {ASC 46}
	}
	else {
		send {ASC 46}
		send {ASC 46}
	}
return

:z0*?:\\::
	ime_s := IME_GET()
	if (ime_s = 1) {
		send {ASC 92}
	}
	else {
		send {ASC 92}
		send {ASC 92}
	}
return

:z0*?:;;::
	ime_s := IME_GET()
	if (ime_s = 1) {
		send {ASC 59}
	}
	else {
		send {ASC 59}
		send {ASC 59}
	}
return

; 由shift + 符号输出的中文标点统一为 alt + shift 输出，原来的功能输出为英文标点
; http://tool.chinaz.com/tools/unicode.aspx
; http://ahkcn.sourceforge.net/docs/Hotstrings.htm

; （）
$!+9::
	send {U+ff08}
	send {U+ff09}{left 1}
return

; 《》
$!+,::
	send {U+300a}
	send {U+300b}{left 1}
return

; “”
$!+'::
	send {U+201c}
	send {U+201d}{left 1}
return

;【】
$!+[::
	send {U+3010}
	send {U+3011}{left 1}
return

; ！
$!+!::
	send {U+ff01}
return

; ：
$!+;::
	send {U+ff1a}
return

; ？
$!+/::
	send {U+ff1f}
return