; ��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
#SingleInstance force

timeInterval := 300
lbtnNotFollowShift := true

#IfWinNotActive ahk_exe mstsc.exe
; Ӣ��ģʽ
~LShift:: 
	; �����ס�� shift ͨ�����ѡ��һ���ַ����л�ΪӢ�����뷨������
	state := GetKeyState("LButton")
	if ( state = 1 )
		lbtnNotFollowShift := false
return
~LShift up::	

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift" && lbtnNotFollowShift) {
		/* ʹ���ѹ��Լ�����������
		if ( WinExist("ahk_class SoPY_Comp") ) {
			Send {Enter}
		}
		*/
		
		Sleep 10
		
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		Sleep 10
		
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
	}
	lbtnNotFollowShift := true
return

; �л����ѹ����뷨����������ģʽ
~$RShift:: 
return
~$RShift up:: 

	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
	
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		Sleep 10
		
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
	
		Sleep 10
		
		Send ^,
		
		Sleep 10
		
		Send ^{Space} ; �����Ϸ�ﲻ���ã�������ĳ� Send +  ��Ȼ�������뷨�� shift �л�״̬���ܣ����� ���뷨�Ŀ�ݼ�ʵ���л�
		; Send {Shift}
	}

return

#IfWinNotActive