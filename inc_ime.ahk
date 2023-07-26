; 输入法增强
#IfWinNotActive ahk_group MyGroup
	
	; 中文标点转英文 https://documentation.help/AutoHotkey/Hotstrings.htm
	:ZB0*?:,,::
		If ( IS_CH_MODE() ) {
			send {bs 2}
			sleep 50
			send {ASC 44}
		}
	return

	:ZB0*?:..::
		If ( IS_CH_MODE() ) {
			send {bs 2}
			sleep 50
			send {ASC 46}
		}
	return

	; :z0*?:\/::
	; 	send {ASC 92}
	; return

	:Zb0*?:;;::
		If ( IS_CH_MODE() ) {
			send {bs 2}
			sleep 50
			send {ASC 59}
		}
	return
	
	; :b1z0*?:_/::
	; 	send {ASC 95}
	; return

	:b0z*?:??::
		If ( IS_CH_MODE() ) {
			send {bs 2}
			sleep 50
			send {ASC 63}
		}
	return

	:b0z*?:::::
		If ( IS_CH_MODE() ) {
			send {bs 2}
			sleep 50
			send {ASC 58}
		}
	return

	:b0z*?:!!::
		If ( IS_CH_MODE() ) {
			send {bs 2}
			sleep 50
			send {ASC 33}
		}
	return

	; 中文输入英文标点模式下，替换英文的标点为中文标点
	:B0z0*?:,/::
		send {bs 2}
		sleep 50
		send {U+FF0C}
	return

	:B0z0*?:./::
		send {bs 2}
		sleep 50
		send {U+3002}
	return

	:B2z0*?:;/::
		send {U+FF1B}
	return
	
	; 中文标点符号
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


	; ：
	$!+:::
		keywait +
		send {U+FF1A}
	return
	
#IfWinNotActive

#include fun_ime.ahk