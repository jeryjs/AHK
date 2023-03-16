#If WinActive("Genshin Impact ahk_exe GenshinImpact.exe")	  ;---------GENSHIN IMPACT-------------------------
F6::Send, {F6}
F8::Goto, F6_Spotify
/::						;Chat
	Send, {/}
	Sleep, 300
	Click(705, 860)		;800, 1000
Return

!g::Send, #g			;game bar

~`::						;Elemental Sight
MButton::
	; Send, {AltDown}
	; Sleep, 200
	; Click(230, 33)		;278, 42
	; Sleep, 200
	; Send, {AltUp}
	Send, {MButton Up}
	Sleep, 10
	Send, {MButton Down}
Return
LAlt & d::GoTo, !d_Discord
*RCtrl::Send, {LButton}	;Atk
+RCtrl::				;Charged Atk
RAlt::
	Send, {LButton Down}
	; Sleep, 200
	Sleep, 350
	Send, {LButton Up}
Return

~f::Click, WheelDown 1

~Alt & CapsLock::		;SwitchDesktop()
~MButton & RButton::
#d::
LCtrl::
Genshin_Boss_Key:
	Send, {g}
	; SoundSet, 0, , , 4
	SwitchDesktop()
Return

; #If (WinActive("ahk_exe GenshinImpact.exe") OR WinExist("ahk_group teyvat_map"))
; CapsLock::BossKey("ahk_group teyvat_map")	;Teyvat Interactive Map

#If