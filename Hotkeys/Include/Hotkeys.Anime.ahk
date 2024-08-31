
#If WinActive("ahk_group anime")	;----------ANIME-----------------------------
NumpadPgUp::Send {Right}
NumpadPgDn::Send {/}
+NumpadPgDn::Send +{/}

XButton1::Send {Right}
XButton2::Send {Left}

; LAlt::
; NumpadEnter::
; RCtrl::
; Ctrl::SwitchDesktop("{Space}", "ahk_group anime","{Space}")

#If ( WinActive("ahk_group anime") AND is Fullscreen() )
w::Send, {Up}
a::Send, {Left}
s::Send, {Down}
d::Send, {Right}
c::Send {/}
+c::Send +{/}
Numpad0::
NumpadIns::
Space::Send, {Space}


#If WinActive("ahk_exe mpvnet.exe")	;---------MPV NET-------------------------------------
+NumpadPgDn::	Send +{PgDn}
; NumpadEnter::
; LAlt::
; RAlt::
; RCtrl::
; LCtrl::
; NumpadAdd::SwitchDesktop("{Space}",, "{Space}", "YouTube")
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
Enter::
	WinActivate, Taiga ahk_exe Taiga.exe
	Send, {Enter}
	Sleep, 300
	Send, !{Tab}
Return     

#If