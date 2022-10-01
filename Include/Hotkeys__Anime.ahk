
#If WinActive("ahk_group anime")	;----------ANIME-----------------------------
NumpadPgUp::Send, {Right)
NumpadPgDn::Send {/}
+NumpadPgDn::Send +{/}
!t::Run, Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe

LAlt::
NumpadEnter::
RCtrl::
Ctrl::SwitchDesktop("{Space}")
Home::SwitchDesktop()

NumpadHome::
WinGetPos,,,W,H,A
If not Fullscreen()	;Check if fullscreen
{
	SendEvent, {Click, 1000, 500, 0}{Click, 1260, 500, 0}
	Click(1260, 800) ;828		;1517 957	;Settings Icon
	Sleep, 700
	Click(1260, 735)		;Speed btn
	Sleep, 300
	Click(1260, 590)		;1.25x btn
	Sleep, 300
	Click(1260, 500)		;993 631
	Click(1260, 500)		;993 631
}
If is Fullscreen()
{
	Click(1490, 875)		;Settings Icon
	Sleep, 700
	Click(1490, 815)		;Speed btn
	Sleep, 300
	Click(1490, 665)		;1.25x btn
	Sleep, 300
	Click(1450, 900)		;Play
	Click(1450, 900)
	Click(1600, 600, 0)		;Move Cursor
}
Return

#If ( WinActive("ahk_group anime") AND is Fullscreen() )
w::Send, {Up}
a::Send, {Left}
NumpadClear::
s::Send, {Down}
d::Send, {Right}


#If WinActive("ahk_exe mpvnet.exe")	;---------MPV NET-------------------------------------
+NumpadPgDn::	Send +{PgDn}
!t::Run, "Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe"
NumpadEnter::
LAlt::
RAlt::
RCtrl::
LCtrl::
NumpadAdd::SwitchDesktop("{Space}",, "{Space}", "YouTube")
Home::SwitchDesktop()


#If WinActive("ahk_exe vlc.exe")	;---------VLC MEDIA PLAYER----------------------------------------
NumpadPgUp::	Send +{Right}
NumpadClear::	Send +{Left}
NumpadPgDn::	Send {/}
+NumpadPgDn::	Send +{/}
!t::Run, Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe


#If WinActive("Taiga ahk_exe Taiga.exe")	;-----------TAIGA-------------------------
!t::WinClose, Taiga ahk_class TaigaMainW

#If WinExist("Taiga ahk_exe Taiga.exe")
!t::Run, Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe

#If WinExist("Taiga ahk_class #32770 ahk_exe Taiga.exe")
Enter::
	WinActivate, Taiga ahk_exe Taiga.exe
	Send, {Enter}
	Sleep, 300
	Send, !{Tab}
Return     

#If