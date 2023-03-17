;-----------------------------------------------------------------------------------------------------------------------
;[F6] Spotify
;-----------------------------------------------------------------------------------------------------------------------
F6::
F6_Spotify:
WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
WinGet, style, Style, ahk_id %spotifyHwnd%
if (style & 0x10000000) 	; WS_VISIBLE
{
	WinHide, ahk_id %spotifyHwnd%
	Send, !{Tab}
}Else {
	WinShow, ahk_id %spotifyHwnd%
	WinActivate, ahk_id %spotifyHwnd%
}
Return

; Send keypress to spotify
spotifyKey(key) {
	; spotifyHwnd := getSpotifyHwnd()
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%	; Focus the document window without bringing the app to the foreground.
	ControlSend, , %key%, ahk_id %spotifyHwnd%
	If WinActive("ahk_class Chrome_WidgetWin_0 ahk_exe Spotify.exe")
		Send, %key%
	Return
}
; Keybinds
#F10::	spotifyKey("{Space}")	; Pause/Play
#Space::spotifyKey("{Space}")	; Pause/Play
#F11::	spotifyKey("^{Right}")	; Next
#F9::	spotifyKey("^{Left}")	; Prev
#+F10::	spotifyKey("+{Right}")	; Forward
#+F9::	spotifyKey("+{Left}")	; Backward
#F8::	spotifyKey("^{Up}")		; Volume Up
#F7::	spotifyKey("^{Down}")	; Volume Down

; Pause on Mute
Current_Volume:
ListLines Off
SoundGet, C_Volume
If ((C_Volume = 0) AND (c != 1))	;Pause spotify & YTM
	{
		WinGetTitle, spotifyTitle, ahk_exe spotify.exe
		If (WinExist("ahk_exe Spotify.exe") AND (spotifyTitle != "Spotify Free"))
			spotifyKey("{Space}")
		Else
		{
			If WinExist("- YouTube Music ahk_exe YouTube Music.exe")
				Send, ^+!{F10}
		}
		c := 1
	}
If ((C_Volume > 0) AND (c = 1))		;Unpause spotify & YTM
	{
		WinGetTitle, spotifyTitle, ahk_exe spotify.exe
		If (WinExist("ahk_exe Spotify.exe") AND (spotifyTitle = "Spotify Free"))
			spotifyKey("{Space}")
		Else
		{
			If WinExist("YouTube Music ahk_exe YouTube Music.exe")
				Send, ^+!{F10}
		}
		c := 0
	}
Return

#If