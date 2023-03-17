;-------------------------------------------------------------------------------
;[WSA] Tachiyomi & Kizzy
;-------------------------------------------------------------------------------
#If WinActive("TachiyomiSY ahk_class eu.kanade.tachiyomi.sy") AND IS Fullscreen()	;-----------TACHIYOMI-------------------------
; Space::
; Shift::
NumpadAdd::
#MaxThreadsPerHotkey 100
	Send, {LButton Up}
	Click
	Sleep, 100
	Click
	Sleep, 300
	Click, 800, 500, 0
	Send, {LButton Down}
	Sleep, 3000
	Send, {LButton Up}
Return

LAlt::
NumpadEnter::
RCtrl::
Ctrl::SwitchDesktop()

Tab::Send, {Left}
Shift::Send, {Right}

!l::SetKizzyRPC("𝐓𝐚𝐜𝐡𝐢𝐲𝐨𝐦𝐢𝐒𝐘", "attachments/961577469427736636/971135180322529310/unknown.png", "𝔐𝔞𝔫𝔤𝔞")


#If WinActive("Kizzy ahk_class com.my.kizzy")				;-----------KIZZY-------------------------
KizzySend(param1) {
	WinActivate, Kizzy ahk_class com.my.kizzy
	Clipboard := param1
	Sleep, 200
	Send, ^a
	Sleep, 100
	Send, ^v
	Sleep, 100
	Send, {Tab}
}

SetKizzyRPC(Kizzy_ActivityName, Kizzy_ImageLink, Kizzy_ActivityState) {
	Kizzy_Token := "OTQ1MTk2MDc5ODQ1MDgxMTIw.YnGHVw.qA_dKCRiQI73mmzD9qUjlPbyJdg"
	If WinExist("Kizzy ahk_class com.my.kizzy")
	{
		Clipboard := "Catchin' up with the new chapters"
		WinActivate, Kizzy ahk_class com.my.kizzy
		Kizzy_ActivityDetails := Clipboard
		ImageSearch, FoundX, FoundY, -52, 127, 514, 349, Z:\DO_NOT_TOUCH\Applications\MacroCreator\Screenshots\Screen_20220608120650.png
		If ErrorLevel
		{
			Click, 200, 100		;Token Input Field
			KizzySend(Kizzy_Token)
			Click, 70, 170		;Save Token
			Sleep, 6000
		}
		Click, 200, 275			;Activity Name Input Field
		KizzySend(Kizzy_ActivityName)
		KizzySend(Kizzy_ImageLink)
		Sleep, 100
		Send, {Tab}
		KizzySend(Kizzy_ActivityState)
		KizzySend(Kizzy_ActivityDetails)
		Click, 200, 610			;Set Activity Btn
	} Else {
		Run, "C:\Users\Jery\AppData\Local\Microsoft\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\WsaClient.exe" /launch wsa://com.my.kizzy
		WinWait, ahk_class com.my.kizzy
	}
}

!l::SetKizzyRPC("𝐓𝐚𝐜𝐡𝐢𝐲𝐨𝐦𝐢𝐒𝐘", "attachments/961577469427736636/971135180322529310/unknown.png", "𝔐𝔞𝔫𝔤𝔞")
!k::SetKizzyRPC("𝐀𝐧𝐢𝐲𝐨𝐦𝐢", "attachments/949382602073210921/985567214193225769/unknown.png", "𝒜𝔫𝔦𝔪𝔢")

#If