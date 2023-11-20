#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
SetTitleMatchMode Fast
DetectHiddenWindows On
DetectHiddenText On
#WinActivateForce
SetControlDelay -1
SetWinDelay -1
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
#UseHook
#Persistent
#InstallKeybdHook
ListLines, Off
#MaxHotkeysPerInterval 200
Process, Priority,, H

RegRead, AHK_Path, HKLM\SOFTWARE\AutoHotkey, InstallDir
#Include Z:\DO_NOT_TOUCH\Environments\AutoHotkey\Lib\VD.ahk
StartTime := A_TickCount

menu, tray, add, Edit This Script, Edit_This_Script
menu, tray, Default, Edit This Script

global Desktop

SetTimer, Battery_Check, 1000
SetTimer, Current_Volume, 10
SoundBeep(10000, 200, 5)


If not A_IsAdmin
{
	; MsgBox, This Script needs to run as Admin for best performance... So do that!!
	Run *RunAs "%A_ScriptFullPath%"
}

; AHK_Groups
GroupAdd, game, Genshin Impact ahk_exe GenshinImpact.exe
GroupAdd, game, Honkai Impact 3rd ahk_class UnityWndClass ahk_exe BH3.exe
GroupAdd, game, Honkai: Star Rail ahk_class UnityWndClass ahk_exe StarRail.exe
GroupAdd, game, God of War ahk_class SonySantaMonica
GroupAdd, game, Detroit: Become Human ahk_class Renderer ahk_exe DetroitBecomeHuman.exe
GroupAdd, game, Nox ahk_exe nox.exe
GroupAdd, game, ahk_class TXGuiFoundation ahk_exe AndroidEmulatorEn.exe
GroupAdd, game, ahk_class Qt5152QWindowIcon ahk_exe MEmu.exe
GroupAdd, game, ahk_exe EXCEL.EXE
; GroupAdd, game, ahk_exe studio64.exe
GroupAdd, game, ahk_exe VALORANT-Win64-Shipping.exe 	; VALORANT ahk_class UnrealWindow ahk_exe VALORANT-Win64-Shipping.exe
GroupAdd, game, ahk_class GameNxApp ahk_exe Spider-Man.exe

GroupAdd, teyvat_map, Teyvat Interactive Map
GroupAdd, teyvat_map, Enkanomiya
GroupAdd, teyvat_map, The Chasm

GroupAdd, anime, - AniMixPlay
GroupAdd, anime, - YugenAnime
GroupAdd, anime, 9Anime -
GroupAdd, anime, - mpv.net
ListLines, On

; Double click tray icon to edit script
Edit_This_Script:
EndTime := A_TickCount
If ((EndTime - StartTime) > 5000)
If GetKeyState("Shift", "P")
	RunAsUser("Z:\DO_NOT_TOUCH\Applications\Microsoft VS Code\Code.exe", "Z:\OneDrive\AHK\AHK.code-workspace -g " A_ScriptFullPath)
Else
	Run, "Z:\DO_NOT_TOUCH\Applications\Notepad++\notepad++.exe" %A_ScriptFullPath%
Return

; Custom SoundBeep
SoundBeep(Frequency, Duration, Volume) {
    SoundGet, MasterVolume
    SoundSet, Volume
	Sleep, 100
    SoundBeep, Frequency, Duration
    SoundSet, MasterVolume
	Sleep, 100
}

; Change Brightness and display brightness in a ToolTip
ChangeBrightness(change) {
	For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightness" )
		currentBrightness := property.CurrentBrightness	
	If (currentBrightness + change) > 100
		changedBrightness := 100
	Else If (currentBrightness + change) < 0
		changedBrightness := 0
	Else
		changedBrightness := currentBrightness + change
	ToolTip("--------------" . changedBrightness . "--------------", , 860, 950)
	Run, nircmd.exe changebrightness %change%
}

; Create a auto hiding ToolTip at cursor location
ToolTip(text, time:=1000, ToolTip_X:="", ToolTip_Y:="") {
	If (ToolTip_X="") AND (ToolTip_Y="")
		MouseGetPos, ToolTip_X, ToolTip_Y
	ToolTip, %text%, %ToolTip_X%, %ToolTip_Y%
	SetTimer, RemoveToolTip, -%time%
	Return
}
RemoveToolTip:
ToolTip
return

; Resolve Resolution in a 16:9 display
; Warning: Incomplete implementation for display with resolution less than 1600x900
ResRes(posx, posy) {
	CoordMode, Mouse, Screen
	If ((A_ScreenWidth > 1600) AND (A_ScreenHeight > 900)) {
		posx := posx * (A_ScreenWidth / 1920.0)
		posy := posy * (A_ScreenHeight / 1080.0)
	} Else If ((A_ScreenWidth < 1600) OR (A_ScreenHeight < 900)) {
		posx := posx / (A_ScreenWidth / 1600.0)
		posy := posy / (A_ScreenHeight / 900.0)
	}
	Return (posx, posy)
}

; Check If fullscreen or not
Fullscreen() {
	WinGetPos,,, w, h, A
	return (w = A_ScreenWidth && h = A_ScreenHeight)
}

; Boss key
BossKey(title) {
	IfWinActive, %title%
	{
		WinMinimize, %title%
		WinHide, %title%
	}Else {
		WinShow, %title%
		WinActivate, %title%
	}
}

; Check whether a process is elevated
ProcessElevated(ProcessID)
{
    if !(hProcess := DllCall("OpenProcess", "uint", 0x1000, "int", 0, "uint", ProcessID, "ptr"))
        throw Exception("OpenProcess failed", -1)
    if !(DllCall("advapi32\OpenProcessToken", "ptr", hProcess, "uint", 0x0008, "ptr*", hToken))
        throw Exception("OpenProcessToken failed", -1), DllCall("CloseHandle", "ptr", hProcess)
    if !(DllCall("advapi32\GetTokenInformation", "ptr", hToken, "int", 20, "uint*", IsElevated, "uint", 4, "uint*", size))
        throw Exception("GetTokenInformation failed", -1), DllCall("CloseHandle", "ptr", hToken) && DllCall("CloseHandle", "ptr", hProcess)
    return IsElevated, DllCall("CloseHandle", "ptr", hToken) && DllCall("CloseHandle", "ptr", hProcess)
}

; Click in all resolutions
Click(x, y, z:=1) {
	x1 := x * (A_ScreenWidth / 1600.0)
	y2 := y * (A_ScreenHeight / 900.0)
	Click, %x1% %y2% %z%
}
; Sends a mouse button or mouse wheel event to a control in all resolutions
ControlClick(x, y, WinTitle, z:="LEFT", c:="1", opt:="") {		; ControlClick(X-Pos, Y-Pos, WinTitle, WhichButton, ClickCount, Options)
	x1 := x * (A_ScreenWidth / 1600.0)
	y2 := y * (A_ScreenHeight / 900.0)
	ControlClick, X%x1% Y%y1%, %WinTitle%,, %z%, %c%, %opt%
}

; Check whether process exists.
ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}

; Return path of active explorer window
GetActiveExplorerPath() {
	explorerHwnd := WinActive("ahk_class CabinetWClass")
	if (explorerHwnd)
	{
		for window in ComObjCreate("Shell.Application").Windows {
			if (window.hwnd==explorerHwnd)
				return window.Document.Folder.Self.Path
		}
	}
}



#If WinExist("ahk_group teyvat_map")
CapsLock::BossKey("ahk_group teyvat_map")	;Teyvat Interactive Map
#If

; DISCORD-------------------------------
<!d::
+Numpad1::
+NumpadEnd::
!d_Discord:
	; IfWinNotExist, Discord ahk_class Chrome_WidgetWin_1
	; 	RunAsUser("C:\Users\Jery\AppData\Local\Discord\Update.exe", "--processStart Discord.exe")
	; Else
		UltraBossKey("Discord", "Discord ahk_class Chrome_WidgetWin_1 ahk_exe DiscordPtb.exe", "shell:AppsFolder\com.squirrel.DiscordPtb.DiscordPtb", "d")
Return
;-----------------------------------------------------------------------------------------------------------------------
;[Alt+*] ULTRA BOSS KEY
;-----------------------------------------------------------------------------------------------------------------------
UltraBossKey(name, title, path, key) {
	IfWinNotExist, %title%
    {
		SplashTextOn, 250, 25, %name%, Press '%key%' to open %name%
		Input, SplashInput, T1 L1
		if (SplashInput = key)
		{
			SplashTextOn, 250, 25, %name%, Opening %name%...
			SoundBeep(6000, 100, 5)
			Run, "%path%"
			WinWait, %title%,,5
			WinActivate, %title%
		}
		SplashTextOff
    }
	Else
		BossKey(title)
}
+NumpadDown::
!y::UltraBossKey("YouTube Music", "ahk_class Chrome_WidgetWin_1 ahk_exe YouTube Music.exe"	, "shell:AppsFolder\com.github.th-ch.youtube-music"				, "y")
!c::UltraBossKey("ChatGPT"		, "ChatGPT ahk_class Chrome_WidgetWin_1"					, "shell:AppsFolder\chat.openai.com-93E9DB25_9andzsn4mr4ca!App"	, "c")
#If !WinActive("ahk_group game")
!w::UltraBossKey("WhatsApp Beta", "WhatsApp Beta ahk_class ApplicationFrameWindow"			, "shell:AppsFolder\5319275A.51895FA4EA97F_cv1g1gvanyjgm!App"	, "w")
!t::UltraBossKey("Taiga"		, "Taiga ahk_class TaigaMainW"								, "Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe"				, "t")

;-----------------------------------------------------------------------------------------------------------------------
;[Shift+Alt+...] Opera Sidebar
;-----------------------------------------------------------------------------------------------------------------------
#If WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe")
+!m::	;------MAL------
	MouseGetPos, posx, posy
	Click("-22", "640")		;-25, 740
	Click("32", "640")		;40, 740
	Click(posx, posy, 0)
Return
; +!1::	;------GMAIL-0------
	; MouseGetPos, posx, posy
	; Click("-22", "673")
	; Click("32", "673")
	; Click(posx, posy, 0)
; Return
; +!2::	;------GMAIL-1------
	; MouseGetPos, posx, posy
	; Click("-22", "725")
	; Click("32", "725")
	; Click(posx, posy, 0)
; Return


;-----------------------------------------------------------------------------------------------------------------------
;[Ctrl+Alt+S] Save Hotkeys.ahk
;-----------------------------------------------------------------------------------------------------------------------
#If WinActive("- Notepad++") OR WinActive(" - Visual Studio Code")
^!s::
	Send, ^s
	; SoundBeep(10000, 200, 5)
	WinActivate, ahk_class Shell_TrayWnd
	Reload		; Restart This script
Return
^+!s::
	{
		IfWinNotExist, Window Spy ahk_exe AutoHotKey.exe
			Run, "Z:\DO_NOT_TOUCH\Environments\AutoHotkey\v2\AutoHotkey32.exe" /force "Z:\DO_NOT_TOUCH\Environments\AutoHotkey\WindowSpy.ahk"
		Else
			WinClose, Window Spy ahk_exe AutoHotKey.exe
	}
	Send, ^+!s
Return
^+!l::ListLines
^+!k::KeyHistory
^+!v::ListVars


#If !WinActive("ahk_group game")
;-----------------------------------------------------------------------------------------------------------------------
;[Shift+F4] Network Monitor
;-----------------------------------------------------------------------------------------------------------------------
F1::
	If !WinExist("Drozd_net_monitor ahk_class AutoHotkeyGUI")
	{
		Run,  %A_ScriptDir%\imports\Drozd_net_monitor_original.lnk
	}Else  {
		If WinActive("Drozd_net_monitor ahk_class AutoHotkeyGUI") and !WinActive("ahk_class Notepad++")
			Send, !{Tab}
		Else If !WinActive("Drozd_net_monitor ahk_class AutoHotkeyGUI") and !WinActive("ahk_class Notepad++")
			WinActivate Drozd_net_monitor ahk_class AutoHotkeyGUI
	}
	If WinActive("ahk_exe notepad++.exe")
		Send, {F1}
Return
+F1::Send, {F1}


;-------------------------------------------------------------------------------
; Turn off NumLock & CapsLock & Show Taskbar/ Toggle F11
;-------------------------------------------------------------------------------
~NumLock::
	Sleep, 60000	;1 min
	SetNumLockState, Off
Return

~CapsLock::
	Sleep, 60000	;1 min
	SetCapsLockState, Off
Return

MButton::
	CoordMode, Mouse, Screen
	MouseGetPos, posx, posy
	
	; If ((A_ScreenWidth > 1600) AND (A_ScreenHeight > 900))
	; {
		; posx := posx / (A_ScreenWidth / 1600.0)
		; posy := posy / (A_ScreenHeight / 900.0)
	; } Else If ((A_ScreenWidth > 1600) AND (A_ScreenHeight > 900)) {
		; posx := posx * (A_ScreenWidth / 1600.0)
		; posy := posy * (A_ScreenHeight / 900.0)
	; }
	
	posx := posx * (A_ScreenWidth / 1920.0)
	posy := posy * (A_ScreenHeight / 1080.0)
		
	If ((posx > 0) AND (posy > 1070))
	{
		If WinActive("ahk_class Shell_TrayWnd")
			Send, !{Tab}
		Else
			WinActivate, ahk_class Shell_TrayWnd ahk_exe Explorer.EXE
	}
	Else If ((posx > 1750) AND (posy < 10))
	{
		Send, {F11}
	}
	Else
		Send, {MButton}
Return

#If		;------------Unlocked All Windows-------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------------------------
; Remaps
;---------------------------------------------------------------------------------------------------------------------

#Include %A_ScriptDir%\Include\Hotkeys.Anime.ahk
#Include %A_ScriptDir%\Include\Hotkeys.BatteryAlarm.ahk
#Include %A_ScriptDir%\Include\Hotkeys.GenshinImpact.ahk
; #Include %A_ScriptDir%\Include\Hotkeys.Spotify.ahk
#Include %A_ScriptDir%\Include\Hotkeys.WSA.ahk
#Include %A_ScriptDir%\Include\Hotkeys.YouTube_Music.ahk


#If WinActive("ahk_class Windows.UI.Core.CoreWindow ahk_exe SearchHost.exe")	;--------SEARCH HOTSTRING------------------------------------------
:*O?:A\::{Home}Apps:{Space}{End}
:*O?:D\::{Home}Documents:{Space}{End}
:*O?:F\::{Home}Folder:{Space}{End}
:*O?:P\::{Home}Photos:{Space}{End}
:*O?:V\::{Home}Videos:{Space}{End}
:*O?:S\::{Home}Settings:{Space}{End}
:*O?:W\::{Home}Web:{Space}{End}
:O:p/::paimon.moe/wish


#If		;--------general HOTSTRING------------------------------------------
:O::lol::😂
:O::lmao::🤣
:O::sweat::😅
:O::exp::😑
:O::sad::😢
:O::cry::😢
:O::sob::😭
:O::smug::😏

:?*O:@g::@gmail.com


#If ( (Fullscreen()) AND (WinActive("- YouTube")) )	;----------YouTube is Fullscreen-----------------------------
w::Send, {Up}
a::Send, {Left}
NumpadClear::
s::Send, {Down}
d::Send, {Right}


#If	;------------------------------------------------NORMAL-----------------------------------------------------------
NumpadIns::Send {Space}
; ~LWin::Send, ^{Esc}
#o::Send, #3		;Opera
#+o::Send, #4		;Edge 
!F11::Run, "Z:\DO_NOT_TOUCH\Applications\IObit\ScreenShot.exe"	 ;Screenshot

#b::				;Taskbar
If WinActive("ahk_class Shell_TrayWnd")
	Send, !{Esc}
Else {
	Send, #{b}
}
Return

#2::				;Phone Link
	IfWinActive, Phone Link ahk_exe PhoneExperienceHost.exe
		WinClose
	Else
		Send, #2
Return

>^>!Left::Run, Display.exe /rotate:90 /toggle		; Rotate Screen Clockwise
>^>!Right::Run, Display.exe /rotate:270 /toggle	; Rotate Screen Counter-Clockwise
>^>!Up::Run, Display.exe /rotate:180 /toggle		; Rotate Screen Vertically

+!1::
+!2::
	SplashTextOn, 230, 25, MAL, Press '1' or '2' to open MAL
	Input, SplashInput, T1 L1
	If (SplashInput = "1")
	{
		Run, "Z:\Videos\MAL"
		SoundBeep(5000, 300, 5)
	}
	ELse If (SplashInput = "2")
	{
		FilePath := GetActiveExplorerPath()
		Run, "Z:\Videos\MAL\Anime Rename.ahk" %FilePath%
		SoundBeep(5000, 300, 5)
	}
	SplashTextOff
Return

; ^+!F6::			; Headphone sound Balance	; Reset audio
	; SoundGet, vol
	; SoundSet, 10
	; VA_SetMasterVolume("5", "0", "Headphone")	; replace '0' with '2' for left channel
	; SoundSet, vol
; Return


;-------------------------------------------------------------------------------
; 4 Finger Wand
;-------------------------------------------------------------------------------
#^+F24::	;4 Finger Tap on touchpad
; ~XButton1 & XButton2::
4FingerWand:
	CoordMode, Mouse, Screen
	MouseGetPos, posx1, posy1
	posx := posx1 * (A_ScreenWidth / 1920.0)
	posy := posy1 * (A_ScreenHeight / 1080.0)
	If ((posx > 1400) AND (posy > 200))		;Quick Settings		bottom-right-large
	{
		Sleep, 10
		Send, #a
	}
	Else If ((posx > 650  AND posx < 1280) AND (posy < 1080 AND posy > 1020))
	{
		Sleep, 10
		Send, ^{Esc}
	}
	Else If ((posx < 600) AND (posy > 200))	;SwitchDesktop		bottom-left-large
	{
		Sleep, 10
		SwitchDesktop()
	}
	Else If ((posx > 1850) AND (posy < 50))	;Edit This Script	top-right-small
	{
		Sleep, 10
		BossKey("ahk_class Chrome_WidgetWin_1 ahk_exe YouTube Music.exe")
	}
	Else If ((posx < 80) AND (posy < 50))	;Discord			top-left-small
	{
		Sleep, 10
		Goto, !d_Discord
	}
	Else	;Notification center
	{
		Sleep, 10
		Send, #n
	}
Return

*WheelUp::
	CoordMode, Mouse, Screen
	MouseGetPos, posx1, posy1,, classnn
	posx := posx1 * (A_ScreenWidth / 1920.0)
	posy := posy1 * (A_ScreenHeight / 1080.0)
	if (posx > 1780) AND (posy > 1030)		;Increase Vol		bottom-right-small
		Send, {volume_Up}{volume_Up}
	Else If (posx < 140) AND (posy > 1030)	;increase Brt		bottom-left-small
		ChangeBrightness(10)
	Else
		Send, {WheelUp}
	Return
*WheelDown::
	CoordMode, Mouse, Screen
	MouseGetPos, posx1, posy1,, classnn
	posx := posx1 * (A_ScreenWidth / 1920.0)
	posy := posy1 * (A_ScreenHeight / 1080.0)
	if (posx > 1780) AND (posy > 1030)		;Decrease Vol		bottom-right-small
		Send, {Volume_Down}{Volume_Down}
	Else If (posx < 140) AND (posy > 1030)	;Decrease Brt		bottom-left-small
		ChangeBrightness(-10)
	Else
		Send, {WheelDown}
	Return

~^+!F4:: ChangeBrightness(-10)
~^+!F5:: ChangeBrightness(20)

#If !WinActive("ahk_group game")
~RButton & LButton Up::Goto, 4FingerWand
~RButton & WheelDown::AltTab
~RButton & WheelUp::ShiftAltTab
#If


;-------------------------------------------------------------------------------
; Switch Desktop
;-------------------------------------------------------------------------------
SwitchDesktop(CharToSend:="", Window:="A",CharToSend2:="" , Window2:="A") {
	; Desktop := VD.getCurrentDesktopNum()
	; MsgBox, %Desktop%
	ControlSend, , %CharToSend%, %Window%
	If (Desktop = 1)
	{
		Desktop := 0
		Send, #^{Left}
	}
	Else
	{
		Desktop := 1
		Send, #^{Right}
	}
	
	If WinExist(Window2)
		Sleep, 500
	If WinActive(Window2)
		Send, %CharToSend2%
}
#+d::
; Desktop := VD.getCurrentDesktopNum()
; MsgBox, %Desktop%
If ((Desktop = 1) OR (Desktop = 2))
{
	Desktop := 0
	Send, #^{Right}
}
Else
{
	Desktop := 1
	Send, #^{Left}
}
Return

+NumpadHome::
#d::SwitchDesktop()

#Numpad1::
#NumpadEnd::VD.goToDesktopNum(1)
#Numpad2::
#NumpadDown::VD.goToDesktopNum(2)
#Numpad3::
#NumpadPgDn::VD.goToDesktopNum(3)


;-------------------------------------------------------------------------------
;[End] Clear Notification & [F12] System Informer
;-------------------------------------------------------------------------------
~End & Home::
	Send, #n
	Sleep, 300
	Send, #n
Return

F12::
WinTitle := "ahk_class MainWindowClassName ahk_exe SystemInformer.exe"
If WinActive(WinTitle)
{
	WinMinimize, %WinTitle%
	WinHide, %WinTitle%
}Else {
	WinShow, %WinTitle%
	WinActivate, %WinTitle%
	Send, ^k
}
Return


;-------------------------------------------------------------------------------
;[#^+H] R-ADB
;-------------------------------------------------------------------------------
#^+h::
IF !ProcessExist("radb.exe") {
	Run, C:\WINDOWS\system32\cmd.exe /c ""Z:\DO_NOT_TOUCH\Tools\gnirehtet-rust-win64\radb.cmd" ",, hide, radbPID
	SoundBeep(3000, 300, 5)
}Else {
	BossKey("ahk_pid "radbPID)
	If !radbPID {
		Run, TaskKill /IM radb.exe /F,, hide
		SoundBeep(5000, 300, 5)
	}
}
Return

#c::
IF !ProcessExist("talk.exe") {
	Run, z:\Documents\All-Projects\talk\talk.exe,,, talkPID
	SoundBeep(3000, 300, 5)
}Else {
	BossKey("ahk_pid "talkPID)
	If !talkPID {
		Run, TaskKill /IM talk.exe /F,, hide
		SoundBeep(5000, 300, 5)
	}
}
Return

;-----------------------------------------------------------------------------------------------------------------------
;the reward for good work is more work!