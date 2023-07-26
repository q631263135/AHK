#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_exe espc.exe

~LAlt & 1::
	loop {
		MouseMove 367, 555

		sleep 500

		MouseClick

		sleep 10000

		; 点我浏览
		ImageSearch, FoundX, FoundY, 237, 571, 420, 848, *50 dwll.png
		sleep 500
		if ( ErrorLevel = 0 ) {
			点我浏览(188, 519)
			点我浏览(393, 519)
			点我浏览(188, 823)
			点我浏览(393, 823)

			back()
			
			continue
		}

		; 点我加购
		ImageSearch, FoundX, FoundY, 26, 262, 429, 548, *50 dwjg.png
		sleep 500
		if ( ErrorLevel = 0 ) {
			点我加购(188, 519)
			点我加购(393, 519)
			点我加购(188, 823)
			点我加购(393, 823)

			back()
			
			continue
		}
		
		; 种草
		ImageSearch, FoundX, FoundY, 26, 565, 429, 847, *50 zc.png
		sleep 500
		if ( ErrorLevel = 0 ) {
			种草(1)

			back()
			
			continue
		}

		; 最后才是浏览8s任务
		ImageSearch, FoundX, FoundY, 27, 459, 173, 553, *50 hd.png
		sleep 1000
		if ( ErrorLevel = 0 ) {
			MouseClickDrag L, 0, 0, 0, -100, , R ;滚动下屏幕，现在活动要求滚动一下
			sleep 9000
		}
		
		back()
		
		/*
		ImageSearch, FoundX, FoundY, 45, 596, 417, 516, *50 qwc.png
		;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 qwc.png

		sleep 500

		if ( ErrorLevel = 0 ) {
			; MouseMove 367, 555 ;“去完成”；向左、向下移动一些距离
			MouseMove FoundX + 35, FoundY + 15 ;“去完成”；向左、向下移动一些距离

			sleep 500

			MouseClick

			sleep 10000

			; 点我浏览
			ImageSearch, FoundX, FoundY, 237, 571, 420, 848, *50 dwll.png
			sleep 500
			if ( ErrorLevel = 0 ) {
				点我浏览(188, 519)
				点我浏览(393, 519)
				点我浏览(188, 823)
				点我浏览(393, 823)

				back()
				
				continue
			}

			; 点我加购
			ImageSearch, FoundX, FoundY, 26, 262, 429, 548, *50 dwjg.png
			sleep 500
			if ( ErrorLevel = 0 ) {
				点我加购(188, 519)
				点我加购(393, 519)
				点我加购(188, 823)
				点我加购(393, 823)

				back()
				
				continue
			}
			
			; 种草
			ImageSearch, FoundX, FoundY, 26, 565, 429, 847, *50 zc.png
			sleep 500
			if ( ErrorLevel = 0 ) {
				种草(1)

				back()
				
				continue
			}

			; 最后才是浏览8s任务
			ImageSearch, FoundX, FoundY, 27, 459, 173, 553, *50 hd.png
			sleep 1000
			if ( ErrorLevel = 0 ) {
				MouseClickDrag L, 0, 0, 0, -100, , R ;滚动下屏幕，现在活动要求滚动一下
				sleep 9000
			}
			
			back()
		} 
		else {
			back()
		
			; 打开京东
			MouseMove 279, 405
			MouseClick

			sleep 3000

			; 一起分10亿
			MouseMove 399, 722
			MouseClick

			sleep 5000

			; 做任务，集炮竹
			MouseMove 392, 668
			MouseClick

			sleep 3000
		}
		*/

		
	}
	
return

~LAlt & 2::
	loop {
		
		MouseMove 367, 637
		
		;mousemove 367, 496 ;微信小程序
		sleep 500

		MouseClick

		sleep 10000

		; 点我浏览
		ImageSearch, FoundX, FoundY, 237, 571, 420, 848, *50 dwll.png
		sleep 500
		if ( ErrorLevel = 0 ) {
			点我浏览(188, 519)
			点我浏览(393, 519)
			点我浏览(188, 823)
			点我浏览(393, 823)

			back()
			
			continue
		}

		; 点我加购
		ImageSearch, FoundX, FoundY, 26, 262, 429, 548, *50 dwjg.png
		sleep 500
		if ( ErrorLevel = 0 ) {
			点我加购(188, 519)
			点我加购(393, 519)
			点我加购(188, 823)
			点我加购(393, 823)

			back()
			
			continue
		}
		
		; 种草
		ImageSearch, FoundX, FoundY, 26, 565, 429, 847, *50 zc.png
		sleep 500
		if ( ErrorLevel = 0 ) {
			种草(1)

			back()
			
			continue
		}

		; 最后才是浏览8s任务
		ImageSearch, FoundX, FoundY, 27, 459, 173, 553, *50 hd.png
		sleep 1000
		if ( ErrorLevel = 0 ) {
			MouseClickDrag L, 0, 0, 0, -100, , R ;滚动下屏幕，现在活动要求滚动一下
			sleep 9000
		}
		
		back()
	}
	
return

~LAlt & 3::
	loop {
		mousemove 367, 496 ;微信小程序
		
		sleep 500

		MouseClick

		sleep 10000

		; 最后才是浏览8s任务
		ImageSearch, FoundX, FoundY, 27, 459, 173, 553, *50 hd.png
		sleep 1000
		if ( ErrorLevel = 0 ) {
			MouseClickDrag L, 0, 0, 0, -100, , R ;滚动下屏幕，现在活动要求滚动一下
			sleep 9000
		}
		
		back()
	}
	
return

back() {
	MouseMove 341, 977 ;移动到返回键
	sleep 1000
	MouseClick
}

点我浏览(x, y) {
	; 点击浏览活动
	/*
	ImageSearch, FoundX, FoundY, 237, 571, 420, 848, *50 dwll.png
	
	sleep 1000
	
	if ( ErrorLevel = 0 ) {
		MouseMove x, y
		
		sleep 1000
		
		MouseClick
		
		sleep 1000
		
		back()
		
		sleep 1000
	}
	*/
	MouseMove x, y
		
	sleep 1000
	
	MouseClick
	
	sleep 1000
	
	back()
	
	sleep 1000
}

点我加购(x, y) {
	/*
	ImageSearch, FoundX, FoundY, 26, 262, 429, 548, *50 dwjg.png
	
	sleep 1000
	
	if ( ErrorLevel = 0 ) {
		MouseMove x, y
	
		sleep 500
	
		MouseClick
	
		sleep 1000
	
		back()
	
		sleep 1000
	}
	*/
	
	MouseMove x, y
	
	sleep 500

	MouseClick

	sleep 1000

	back()

	sleep 1000
}

种草(c) {
	if (c > 4) {
		back()
	}

	c := c + 1

	ImageSearch, FoundX, FoundY, 26, 565, 429, 847, *50 zc.png
	sleep 1000
	if ( ErrorLevel = 0 ) {
		MouseMove 325, 791
		
		sleep 1000
		
		MouseClick
		
		sleep 1000
		
		back()

		sleep 1000

		种草(c)
	}
}


#IfWinActive

~LAlt & 4::Reload

