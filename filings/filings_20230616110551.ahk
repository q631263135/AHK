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



	; 双击 alt 打开思源笔记
	/*
	~LCtrl up::
		IfWinNotActive ahk_class MHXYMainFrame 
		{
			if (A_PriorHotkey = "~LCtrl up" && A_TimeSincePriorHotkey < 400)
			{
				ifWinExist ahk_exe SiYuan.exe 
				{
					winactivate
					;send ^{PgUp}
				}
				else 
				{
					run D:\app\SiYuan\SiYuan.exe
				}
			}
		
		}
	return
	*/

		<#q::
		KeyWait LWin
		Run, 360se.exe https://www.dida365.com/webapp/#q/all/today
		;WinMinimize 开发商桌面-开发 - Desktop Viewer
	return

	; 云桌面内的 ditto 快捷键冲突处理
/*
#IfWinActive ahk_exe CDViewer.exe
	^`::
		send ^+!v
	return
#IfWinActive
*/