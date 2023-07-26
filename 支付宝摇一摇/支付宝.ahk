#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#IfWinActive ahk_exe espc.exe

global stopFlag := false

~LAlt & 1::
	stopFlag := !stopFlag
	
	while(stopFlag) {
		CoordMode, Window

		MouseMove 233, 804
		MouseClick
		sleep 2000

		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 close.png

		sleep 500

		if ( ErrorLevel = 0 ) {
			MouseMove 226, 757
			sleep 500
			MouseClick
		}
	}
	
return

#IfWinActive 

~LAlt & 2::Pause

~LAlt & 3::Reload