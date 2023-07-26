Menu, Tray, Icon, 1.ico, 1, 1

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_exe MEmu.exe

; global start_click := false

WheelDown::

	; start_click := false

	;{SPACE}{WAITMS<100>}{Numpad1}{WAITMS<100>}{Numpad2}{WAITMS<100>}{Numpad3}{WAITMS<100>}{Numpad4}{WAITMS<300>}
	send {space}
	sleep 100
	send {Numpad1}
	sleep 100
	send {Numpad2}
	sleep 100
	send {Numpad3}
	sleep 100
	send {Numpad4}
	sleep 300
return

WheelUp::
	;{Numpad5}{WAITMS<500>}{Numpad6}{WAITMS<300>}{Numpad7}{WAITMS<1000>}{Numpad8}{WAITMS<500>}{Numpad9}{WAITMS<200>}{Numpad0}{WAITMS<200>}{Numpad+}
	send {Numpad5}
	sleep 500
	send {Numpad6}
	sleep 300
	send {Numpad7}
	sleep 1000
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 确定.png
	sleep 500
	if ( ErrorLevel = 0 ) {
		send {NumpadDot}
		sleep 500
	}
	send {Numpad8}
	sleep 500

	; ImageSearch, FoundX, FoundY, 0, 0, 490, 218, *50 mhkd_gb.png
	; sleep 200
	
	; if ( ErrorLevel = 0 ) {
		
	; }


	send {Numpad9}
	sleep 200
	send {Numpad0}
	sleep 500

	ImageSearch, FoundX, FoundY, 0, 0, 390, 218, *50 mhkd_fy.png

	sleep 500
	if ( ErrorLevel = 0 ) {
		MouseMove FoundX + 35, FoundY + 15
	}


	; if (!start_click) {
	; 	start_click = true
	; 	MouseMove 326, 374
		
	; 	while (start_click) {
	; 		sleep 1000
	; 		MouseClick
	; 	}
	; }
	
return

~RButton Up::
	send {Numpad7}
	sleep 1000
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 确定.png
	sleep 500
	if ( ErrorLevel = 0 ) {
		send {NumpadDot}
		sleep 500
	}
	send {Numpad8}
	sleep 500

	; ImageSearch, FoundX, FoundY, 0, 0, 490, 218, *50 mhkd_gb.png
	; sleep 200
	
	; if ( ErrorLevel = 0 ) {
		
	; }


	send {Numpad9}
	sleep 200
	send {Numpad0}
	sleep 500

	ImageSearch, FoundX, FoundY, 0, 0, 390, 218, *50 mhkd_fy.png

	sleep 500
	if ( ErrorLevel = 0 ) {
		MouseMove FoundX + 35, FoundY + 15
	}

return


#IfWinActive 