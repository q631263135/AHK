Menu, Tray, Icon, Sirea-Angry-Birds-Bird-blue.ico, 1, 1
#Include %A_ScriptDir%
#include inc_ime.ahk



GroupAdd, g, ahk_exe mstsc.exe
GroupAdd, g, ahk_exe SunloginClient.exe
return



#IfWinNotActive g mstsc.exe 

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
		FileCopyDir, %clipboard%, E:\Inbox\%SourceFolderName%
		
		If ErrorLevel = 0
			FileRemoveDir, %clipboard%, 1
		Else
		{
			MsgBox, 20, Error , A moving of the folder "%clipboard%" occurs error, Open the Inbox ?
			IfMsgBox Yes
				run, explorer E:\Inbox
		}
	}
	Else
	{
		FileCopy, %clipboard%, E:\Inbox, 0
		if ErrorLevel = 0
		
			FileDelete, %clipboard%
		Else
		{
			MsgBox, 20, Error, A moving of the file "%clipboard%" occurs error, Open the Inbox ?
			IfMsgBox Yes
				run, explorer E:\Inbox
		}
	}
return

; 打开电脑工具
<#t::run, explorer E:\tools

; 打开滴答清单
<#q::
	KeyWait LWin
	Run, C:\Users\ycz\AppData\Roaming\360se6\Application\360se.exe https://www.dida365.com/webapp/#q/all/today
	;WinMinimize 开发商桌面-开发 - Desktop Viewer
return

; 思源笔记
#IfWinActive ahk_exe SiYuan.exe
	^1::
		send ^!1
	return
	
	^2::
		send ^!2
	return
	
	^3::
		send ^!3
	return
	
	^4::
		send ^!4
	return
	
	^5::
		send ^!5
	return
	
	/*
	!q::
		IfWinNotActive ahk_class MHXYMainFrame 
		{	
			ifWinActive ahk_exe SiYuan.exe
			{
				send !5
			} 
			else
			{
				ifWinExist ahk_exe SiYuan.exe 
				{
					winactivate
					send !5
				}
				else 
				{
					run D:\app\SiYuan\SiYuan.exe
					send !5
				}
			}
		}
	return
	*/
#IfWinActive

; ONENOTE
#IfWinActive ahk_exe ONENOTE.EXE
	^1::
		send ^!1
	return
	
	^2::
		send ^!2
	return
	
	^3::
		send ^!3
	return
	
	^4::
		send ^!4
	return
	
	^5::
		send ^!5
	return
#IfWinActive

#IfWinNotActive
/*
#IfWinActive ahk_class TscShellContainerClass
		
	LAlt & CapsLock::           ; Ctrl+Caps Lock (couldn't make Ctrl+Shift+Caps Lock work for some reason
    	; Need a short sleep here for focus to restore properly.
    	Sleep 100
    	WinMinimize A    ; need A to specify Active window
    	; MsgBox, Received Remote Desktop minimize hotkey    ; uncomment for debugging
  	return
  	
#IfWinActive
*/

/********************************************************************** DEMO **********************************************************************/
/*


#IfWinActive ahk_class TscShellContainerClass
		
	LAlt & CapsLock::           ; Ctrl+Caps Lock (couldn't make Ctrl+Shift+Caps Lock work for some reason
    	; Need a short sleep here for focus to restore properly.
    	Sleep 100
    	WinMinimize A    ; need A to specify Active window
    	; MsgBox, Received Remote Desktop minimize hotkey    ; uncomment for debugging
  	return
  	
#IfWinActive

; 打开坚果云
<#j::run, explorer E:\AppData\我的坚果云


; 打开电脑工具
<#t::run, explorer E:\tools
*/