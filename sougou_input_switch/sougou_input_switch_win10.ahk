; ��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
; ֻ�����ѹ����뷨���� shift ��Ӣ���л����أ���ĳЩӦ���У������� shift �����л����ĵ�����
#SingleInstance force
Menu, Tray, Icon, sougou.ico, 1, 1

GroupAdd, MyGroup, ahk_exe mstsc.exe
GroupAdd, MyGroup, ahk_exe CDViewer.exe

timeInterval := 300
lbtnNotFollowShift := true


#IfWinNotActive ahk_group MyGroup
	; Ӣ��ģʽ
	~LShift:: 
		; �����ס�� shift ͨ�����ѡ��һ���ַ����л�ΪӢ�����뷨������
		state := GetKeyState("LButton")
		if ( state = 1 )
			lbtnNotFollowShift := false
	return
	~LShift up::	

		if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && lbtnNotFollowShift) {

			if ( WinExist("ahk_class SoPY_Comp") ) {
				Send {Enter}
			}
			
			Sleep 10
			
			if ( GetKeyState("CapsLock", "T") ) {
				SetCapsLockState, Off
			}
			
			Sleep 10
			
			DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
			
			; Sleep 10
			
			; IME_SET(0)
		}
		lbtnNotFollowShift := true
	return

	; �л����ѹ����뷨����������ģʽ
	~$RShift:: 
	return
	~$RShift up:: 

		if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
			Send ^,
		
			Sleep 10

			; IME_SET(1)
			
			if ( GetKeyState("CapsLock", "T") ) {
				SetCapsLockState, Off
			}
			
		}
	return
#IfWinNotActive

#include IME.ahk