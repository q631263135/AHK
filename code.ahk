Menu, Tray, Icon, Sirea-Angry-Birds-Bird-blue.ico, 1, 1

GroupAdd, �༭��, ahk_class Notepad++
GroupAdd, �༭��, ahk_class TPLSQLDevForm
GroupAdd, �༭��, ahk_exe ONENOTE.EXE
GroupAdd, �༭��, ahk_exe Typora.exe
GroupAdd, �༭��, ahk_exe sublime_text.exe

GroupAdd, ʹ��Ӣ�ı��, ahk_exe idea64.exe
GroupAdd, ʹ��Ӣ�ı��, ahk_exe webstorm64.exe
GroupAdd, ʹ��Ӣ�ı��, ahk_class TPLSQLDevForm
GroupAdd, ʹ��Ӣ�ı��, ahk_class PX_WINDOW_CLASS
GroupAdd, ʹ��Ӣ�ı��, ahk_exe Code.exe

GroupAdd, �����, ahk_exe firefox.exe
GroupAdd, �����, ahk_exe msedge.exe
GroupAdd, �����, ahk_exe chrome.exe
GroupAdd, �����, ahk_exe 360se.exe

GroupAdd, jetbrain, ahk_exe idea64.exe
GroupAdd, jetbrain, ahk_exe webstorm64.exe
return

; ���ַ����滻
; * ����Ҫ��ֹ�� ?0 �����������ʺ���
:*?0:ymd::yyyy-MM-dd

::rq::
	if not WinExist("ahk_class SoPY_Comp") {
		FormatTime, currentDate, %A_Now%, yyyy-MM-dd
		send, %currentDate%
	}
return

; �༭�� 
#IfWinActive ahk_group �༭��
	; shift + enter �²�����
	$+Enter::
		send {End}
		send {Enter}
	return

	; alt + ctrl + enter �ϲ�����
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


; ʹ��Ӣ�ı�� 
#IfWinActive ahk_group ʹ��Ӣ�ı��
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


; �����
#IfWinActive ahk_group �����

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
			ToolTipFont("s10", "΢���ź�")
			ToolTipColor("Blue", "White")	
			ToolTip, ��
		} else {	
			if (imeMode = 1) {
				ToolTipFont("s10", "΢���ź�")
				ToolTipColor("Red", "White")
				ToolTip, ��
			} else {
				ToolTipFont("s10", "΢���ź�")
				ToolTipColor("Green", "White")
				ToolTip, ��
				; ToolTip, ��, A_ScreenWidth / 2, A_ScreenHeight / 2
			}
		
		}
		
		SetTimer, ToolTipOff, -800

	}
}

#include inc_plsql.ahk
#include inc_joyin_db.ahk

#include fun_ime.ahk
#include fun_tooltip.ahk