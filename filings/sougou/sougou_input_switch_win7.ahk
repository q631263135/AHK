; ��Shiftǿ���л���Ӣ�����뷨����Shiftǿ���л����������뷨
#Include %A_ScriptDir%

timeInterval := 500

; Ӣ��ģʽ
~$LShift:: 
return
~$LShift up::

	if (A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "LShift") {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		if ( WinExist("ahk_class SoPY_Comp") ) {
			Send {Enter}
		}
		
		;Sleep 100 ; ���ѹ����л���Ȼ��ǿ�Ƹ�ΪӢ��
		
		;ime_status := IME_GetConvMode()
		
		;send %ime_status%
		
		;�� 2020-7-15 ͻȻ�Ͳ������ˣ����� ime_status ������� 0�������뷨��Ȼ������ģʽ
		
		IME_SetConvMode(0)
	}
	
return

; �л����ѹ����뷨����������ģʽ
~$RShift:: 
return
~$RShift up:: 


	if ( A_TimeSincePriorHotkey < timeInterval && A_Priorkey = "RShift" ) {
		if ( GetKeyState("CapsLock", "T") ) {
			SetCapsLockState, Off
		}
		
		if ( !WinExist("ahk_class SoPY_Comp") ) {
			Send ^,
		}
		
		; Sleep 300 ; ���ѹ����л���Ȼ��ǿ�Ƹ�Ϊ����
		
		IME_SetConvMode(1025) ; 0x10000401
	}

return

#include IME.ahk
#include replace_punctuation.ahk