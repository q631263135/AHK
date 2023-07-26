#IfWinNotActive ahk_group MyGroup

	; select word caret
	CapsLock & u::
		click, 2
	return

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
		if GetKeyState("alt") != 0 {
			send {Home}
		}
		else if GetKeyState("ctrl") != 0 {
			send ^{Left}
		}
		else if GetKeyState("shift") != 0
			send +{Left}
		else {
			send {Left}
		}
	return

	; 光标右移，如果同时按住 Alt 键，移动到行尾
	CapsLock & l::
		if GetKeyState("alt") != 0 {
			send {End}
		}
		else if GetKeyState("ctrl") != 0 {
			send ^{Right}
		}
		else if GetKeyState("shift") != 0
			send +{Right}
		else {
			send {Right}
		}
	return

	; 切换桌面
	CapsLock & WheelUp::
		Send {LWin Down}{Ctrl Down}{Left}{Ctrl Up}{LWin Up}
	return

	CapsLock & WheelDown::
		Send {LWin Down}{Ctrl Down}{Right}{Ctrl Up}{LWin Up}
	return

	CapsLock & ,::
		Send {U+002C}
	return

	CapsLock & .::
		Send {U+002E}
	return

	^Capslock::
		Send {Delete}
	return

#IfWinNotActive