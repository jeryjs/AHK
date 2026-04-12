#If (WinActive(" · Miruro") AND Fullscreen())
/::
NumpadPgDn::
C::Send, +{Enter}


#If ( WinActive("ahk_group anime") AND is Fullscreen() )	;----------ANIME-----------------------------
NumpadPgUp::Send {Right}
NumpadPgDn::Send {/}
+NumpadPgDn::Send +{/}

WheelLeft::
XButton1::Send {Right}
WheelRight::
XButton2::Send {Left}

; LAlt::
; RCtrl::
; Ctrl::SwitchDesktop("{Space}", "ahk_group anime","{Space}")

NumpadUp::
w::Send, {Up}
NumpadClear::
NumpadLeft::
a::Send, {Left}
NumpadDown::
s::Send, {Down}
NumpadRight::
d::Send, {Right}
c::Send {/}
+c::Send +{/}
Numpad0::
NumpadIns::
Space::Send, {Space}

NumpadEnter::
Enter::
f::Send, {Esc}


#If WinActive("ahk_exe mpvnet.exe")	;---------MPV NET-------------------------------------
+NumpadPgDn::	Send +{PgDn}
; NumpadEnter::
; LAlt::
; RAlt::
; RCtrl::
; LCtrl::
; NumpadAdd::SwitchDesktop("{Space}",, "{Space}", "A")
; Home::SwitchDesktop()

XButton1::Send {Right}
XButton2::Send {Left}


#If WinActive("ahk_exe vlc.exe")	;---------VLC MEDIA PLAYER----------------------------------------
NumpadPgUp::	Send +{Right}
NumpadClear::	Send +{Left}
NumpadPgDn::	Send {/}
+NumpadPgDn::	Send +{/}


#If WinActive("Aniyomi ahk_class xyz.jmir.tachiyomi.mi.debug")	;---------Aniyomi-------------------------------------
NumpadClear:: Send a	; left
XButton1::Send d		; right
XButton2::Send a		; left


#If WinActive("Advanced Search - Opera")
Ctrl::SwitchDesktop("{Space}",,"{Space}")
NumpadEnter::SwitchDesktop("{Space}","Advanced Search - Opera","{Space}")


#If WinExist("Taiga ahk_class #32770 ahk_exe Taiga.exe")	;-----------TAIGA-------------------------
Space::
NumpadEnter::
NumpadIns::
Numpad0::
Enter::
	WinActivate, Taiga ahk_exe Taiga.exe
	Send, {Enter}
	Sleep, 300
	Send, !{Tab}
Return     

#If