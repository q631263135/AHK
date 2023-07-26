;#NoEnv
#SingleInstance force
Menu, Tray, Icon, Sirea-Angry-Birds-Bird-red.ico, 1, 1

GroupAdd, MyGroup, ahk_exe CDViewer.exe ; 华泰开发商桌面
GroupAdd, MyGroup, ahk_exe mstsc.exe

timeInterval := 300
lbtnNotFollowShift := true

isToRight := true

; 输入法增强
#include inc_ime.ahk
; CAPS
#include inc_caps.ahk

return

#IfWinNotActive ahk_group MyGroup

	; 收件箱
	<#i::
		KeyWait LWin
		clipboard =
		Send ^c
		ClipWait
		
		FileGetAttrib, Attributes, %clipboard%
		If InStr(Attributes, "D") 
		{
			SplitPath, clipboard, SourceFolderName
			FileCopyDir, %clipboard%, F:\Inbox\%SourceFolderName%
			
			If ErrorLevel = 0
				FileRemoveDir, %clipboard%, 1
			Else
			{
				MsgBox, 20, Error , A moving of the folder "%clipboard%" occurs error, Open the Inbox ?
				IfMsgBox Yes
					run, explorer F:\Inbox
			}
		}
		Else
		{
			FileCopy, %clipboard%, F:\Inbox, 0
			if ErrorLevel = 0
				FileDelete, %clipboard%
			Else
			{
				MsgBox, 20, Error, A moving of the file "%clipboard%" occurs error, Open the Inbox ?
				IfMsgBox Yes
					run, explorer F:\Inbox
			}
		}
	return



	; 中转站
	<#j::
		KeyWait LWin
		clipboard =
		Send ^c
		ClipWait
		
		FileGetAttrib, Attributes, %clipboard%
		If InStr(Attributes, "D") 
		{
			SplitPath, clipboard, SourceFolderName
			FileCopyDir, %clipboard%, F:\我的坚果云\文件中转站\%SourceFolderName%
			
			If ErrorLevel = 0
				FileRemoveDir, %clipboard%, 1
		}
		Else
		{
			FileCopy, %clipboard%, F:\我的坚果云\文件中转站, 0
			if ErrorLevel = 0
				FileDelete, %clipboard%
		}
	return



	; 最小化当前激活的窗口
	<#q::
		WinMinimize, A
	return



	; 切换窗口到另一个显示器
	<#z::
		KeyWait LWin
		Send {LWin Down}{Shift Down}{Right}{Shift Up}{LWin Up}
	return
	


	; 关闭所有资源管理器
	$<#w::
		GroupAdd, Explore, ahk_class CabinetWClass
		GroupClose, Explore, A
	return



	; 最大化窗口
	LWin & WheelUp::
		keywait LWin
		Send {LWin Down}{Up}{LWin Up}
		keywait, LWin, Up
	return


	; 打开计算器
	; ::/cc::
	; 	IfWinNotExist ahk_class CalcFrame
	; 	{
	; 	  Run calc.exe
	; 	  WinActivate
	; 	}
	; 	Else IfWinNotActive ahk_class CalcFrame
	; 	{
	; 	  WinActivate
	; 	}
	; Return

	

	; 打开画图
	::/pp::
	IfWinNotExist ahk_class MSPaintApp
	{
	  Run mspaint.exe
	  WinActivate
	}
	Return
	
#IfWinNotActive



; 双击 alt
~LAlt up::
	IfWinNotActive ahk_class MHXYMainFrame 
	{
		if (A_PriorHotkey = "~LAlt up" && A_TimeSincePriorHotkey < 300)
		{
			IfWinActive ahk_exe CDViewer.exe 
			{
				WinMinimize 开发商桌面-开发 - Desktop Viewer

				return
			} 
			
			IfWinActive ahk_exe mstsc.exe
			{
				WinMinimize 192.168.3.199 - 远程桌面连接

				return
			}	


			IfWinExist ahk_exe 360se.exe 
			{
				winactivate

				;run C:\Users\joyin\AppData\Roaming\360se6\Application\360se.exe
				;Run https://cn.bing.com/?FORM=BEHPTB
			
				return
			}	
			
			; 切换虚拟桌面
			; if (isToRight := !isToRight) 
			; {
			; 	Send {LWin Down}{Ctrl Down}{Right}{Ctrl Up}{LWin Up}
			; }
			; else 
			; {
			; 	Send {LWin Down}{Ctrl Down}{Left}{Ctrl Up}{LWin Up}
			; }
		}
	
	}
return




; 如果没开梦幻西游,修改alt按键的多个功能
#IfWinNotActive ahk_class MHXYMainFrame
	!WheelUp::
		send ^{Home}
	return

	!WheelDown::
		send ^{End}
return



; 打开微信.如果微信窗口不存在则打开,存在则输入查询;可以在不移动手指的情况下查询聊天人
!v::
	IfWinNotActive ahk_class WeChatMainWndForPC
	{
		send ^!w
	} 
	Else 
	{
		IfWinActive ahk_class WeChatMainWndForPC 
		{
			send ^f
		}
		
	}
	
return 



; 英文模式
~$LShift:: 
	; 解决按住左 shift 通过鼠标选择一串字符会切换为英文输入法的问题
	state := GetKeyState("LButton")
	if ( state = 1 )
		lbtnNotFollowShift := false
return
~$LShift up::

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && lbtnNotFollowShift) {

		; if ( WinExist("ahk_class SoPY_Comp") ) {
		; 	Send {Enter}
		; }
		
		; Sleep 10

		; Send,  {ctrl}
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		; Sleep 10
		
		; DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
		
		Sleep 10
		
		IME_SET(0)
	}

	; if (!lbtnNotFollowShift) {
	; 	send {Shift}
	; }
	
	lbtnNotFollowShift := true
return

; 切换到搜狗输入法，设置中文模式
~$RShift:: 
	return
~$RShift up:: 

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		;Send ^,
	
		Sleep 10

		IME_SET(1)
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
	}
return

#IfWinNotActive




; auto hotstring
#h::
	ClipboardOld = %ClipboardAll%
	Clipboard =  ; Must start off blank for detection to work.
	Send ^c
	ClipWait 1

	if ErrorLevel  ; ClipWait timed out.
	    return

	StringReplace, Hotstring, Clipboard, ``, ````, All  ; Do this replacement first to avoid interfering with the others below.
	StringReplace, Hotstring, Hotstring, `r`n, ``r, All  ; Using `r works better than `n in MS Word, etc.
	StringReplace, Hotstring, Hotstring, `n, ``r, All
	StringReplace, Hotstring, Hotstring, %A_Tab%, ``t, All
	StringReplace, Hotstring, Hotstring, `;, ```;, All
	Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.

	InputBox, Hotstring, New Hotstring, 此时此刻，恰如彼时彼刻,,,,,,,, #Numpad::%Hotstring%


	if ErrorLevel <> 0  ; The user pressed Cancel.
	    return
	    
	; Otherwise, add the hotstring and reload the script:
	FileAppend, `n%Hotstring%, %A_ScriptFullPath%  ; Put a `n at the beginning in case file lacks a blank line at its end.
	Reload
	Sleep 200 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	
	MsgBox, 4,, The hotstring just added appears to be improperly formatted.  Would you like to open the script for editing? Note that the bad hotstring is at the bottom of the script.
	IfMsgBox, Yes, Edit
return


#Numpad1::run, E:\AppData\Wechat\WeChat Files\wxid_riao07epjz1i41\FileStorage\File\2023-06