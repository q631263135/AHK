; =================================================================================== PL/SQL Developer ===================================================================================

#IfWinActive ahk_class TPLSQLDevForm

	::ob::order by

	:*?:fup::for update;

	:o:twt::t where t.

	:o:wt::where t.

	:o:gb::group by 

	:o:w::where 

	:O:tochar::to_char(sysdate, 'yyyy-MM-dd')

	::sguid::
		send select lower(sys_guid()) from dual;
	return

	::scount::
		send select count(1) from ;
	return

	::del::
		send delete from 
		send {space}
	return

	::sseq::
		send select s_.nextval from dual; {left 20}
	return

	::like::
		if not WinExist("ahk_class SoPY_Comp") {
			send like '`%`%';
			send {left}
			send {left}
			send {left}
		}
	return

	^!down::
		send {end}
		send +{home}
		send ^c
		send {end}
		send {enter}
		send ^v
	return	

	^d::
		send {end}
		send +{home}
		send ^c
		send {end}
		send {enter}
		send ^v
	return 

	!/::
		send {f6}
	return

	^q::
		send {Home}
		send +{End}
		send {F8}
	return

	!q::
		if not WinExist("ahk_class SoPY_Comp") {
			send {Home}
			send select * from 
			sleep 200
			send {Space}
			send {Home}
			sleep 200
			send +{End}
			sleep 200
			send {F8}
		}
	return

	!F8::
		send +{Home}
		send {F8}
	return

	^F8::
		send {Home}
		send +{End}
		send {F8}
	return

	; 向左滚动
	~LControl & WheelUp::
		ControlGetFocus, fcontrol, A
		Loop 2 ; 增加这个值来加快滚动速度.
			SendMessage, 0x114, 0, 0, %fcontrol%, A ; 0x114 是 WM_HSCROLL, 它后面的 0 是 SB_LINELEFT.
	return

	; 向右滚动
	~LControl & WheelDown::  
		ControlGetFocus, fcontrol, A
		Loop 2
			SendMessage, 0x114, 1, 0, %fcontrol%, A  
	return

	CapsLock & Space::
		Send {space}
		send {=} ''
		send {left}
	return

	; ctrl + tab 替换为 ctrl + shift + tab
	$^tab::^+tab
#IfWinActive