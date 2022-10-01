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
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
#UseHook
#Persistent
#InstallKeybdHook
ListLines, Off
; #Include Anime {Hotkeys}.ahk
; KeyHistory
; #Warn All
#MaxHotkeysPerInterval 200
StartTime := A_TickCount

menu, tray, add, Edit This Script, Edit_This_Script
menu, tray, Default, Edit This Script

SetTimer, Battery_Check, 10000
SetTimer, Current_Volume, 10
SoundBeep(10000, 200, 5)


If not A_IsAdmin
{
	MsgBox, This Script needs to run as Admin for best performance... So do that!!
	Run *RunAs "%A_ScriptFullPath%"
}

; AHK_Groups
GroupAdd, game, Genshin Impact ahk_exe GenshinImpact.exe
GroupAdd, game, Nox ahk_exe nox.exe
GroupAdd, game, ahk_class TXGuiFoundation ahk_exe AndroidEmulatorEn.exe
GroupAdd, game, ahk_exe EXCEL.EXE
GroupAdd, game, ahk_exe studio64.exe
GroupAdd, game, ahk_exe VRChat.exe

GroupAdd, teyvat_map, Teyvat Interactive Map
GroupAdd, teyvat_map, Enkanomiya
GroupAdd, teyvat_map, The Chasm

GroupAdd, anime, - AniMixPlay
GroupAdd, anime, 9Anime -
ListLines, On

; Double click tray icon to edit script
Edit_This_Script:
EndTime := A_TickCount
If ((EndTime - StartTime) > 3000)
If GetKeyState("Shift", "P")
	RunAsUser("Z:\DO_NOT_TOUCH\Applications\Notepad++\notepad++.exe", A_ScriptFullPath)
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
ControlClick(x, y, WinTitle, z:="LEFT", c:="1", opt:="") {		; ControlClick(X-Pos, Y-Pos, WinTitle, WhichButton, ClickCount, Options)
	x1 := x * (A_ScreenWidth / 1600.0)
	y2 := y * (A_ScreenHeight / 900.0)
	ControlClick, X%x1% Y%y1%, %WinTitle%,, %z%, %c%, %opt%
}


#If WinExist("ahk_group teyvat_map")
CapsLock::BossKey("ahk_group teyvat_map")	;Teyvat Interactive Map
#If



;-----------------------------------------------------------------------------------------------------------------------
;[Alt+D] Discord
;-----------------------------------------------------------------------------------------------------------------------
!d::
!d_Discord:
	; ControlFocus, Intermediate D3D Window1, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
	; ControlGet, OutputVar1, Hwnd, , Intermediate D3D Window1, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe,,,
    IfWinNotExist, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
    {
		SplashTextOn, 200, 25, Discord, Press 'd' to open Discord
		Input, SplashInput, T1 L1
		If (SplashInput = "d")
		{
			SoundBeep(6000, 100, 5)
			Run, "C:\Users\Jery\AppData\Local\Discord\app-1.0.9004\Discord.exe"
			; WinActivate, Discord ahk_exe Discord.exe
			WinWait, Discord ahk_exe Discord.exe, ,8 , Discord Updater
			WinHide, Discord ahk_exe Discord.exe,, Discord Updater
		}
		SplashTextOff
    }
    Else
	{
		; WinGet, Discord_PID, PID, ahk_exe Discord.exe
		; If ProcessElevated(Discord_PID)		;check whether Discord is Elevated
		; {
			; IfWinNotActive, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe	; If Discord not in Foreground
			; {
				; WinShow, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe ahk_id %Discord_ID%
				; WinActivate, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe ahk_id %Discord_ID%
				; ControlGet, Discord_Visibility, Visible,, Intermediate D3D Window1, ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
				; If Discord_Visibility != 1	; If Discord is not Visible
				; {
					; WinHide, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
					; Send, !{Esc}
					; WinShow, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
					; WinActivate, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
				; }
				; WinGet, Discord_ID, ID, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
			; }Else  {																	; If Discord is in Foreground
				; WinMinimize, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe ahk_id %Discord_ID%
				; WinHide, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe ahk_id %Discord_ID%
			; }
		; }
		; Else									; If Discord is not Elevated
			BossKey("Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe")
	}
Return


#If !WinActive("ahk_group game")
;-----------------------------------------------------------------------------------------------------------------------
;[Alt+W] WhatsApp Beta
;-----------------------------------------------------------------------------------------------------------------------
!w::
    IfWinNotExist, WhatsApp Beta ahk_exe ApplicationFrameHost.exe
    {
		IfWinActive, ahk_exe opera.exe
			Send, !w
		Else {
			SplashTextOn, 200, 25, WhatsApp, Press 'w' to open WhatsApp
			Input, SplashInput, T1 L1
			if (SplashInput = "w")
			{
				SoundBeep(6000, 100, 5)
				; Run, "C:\Program Files\WindowsApps\5319275A.WhatsAppDesktop_2.2222.12.0_x64__cv1g1gvanyjgm\app\WhatsApp.exe"
				Run, "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\WhatsApp Beta.lnk"
				WinActivate, WhatsApp
			}
			SplashTextOff
		}
	}
    Else
    {
	WA:="WhatsApp Beta ahk_exe ApplicationFrameHost.exe"
		IfWinNotActive, %WA%
		{
			; WinShow, WhatsApp Voip
			; WinShow, call ahk_exe WhatsApp.exe
			WinShow, %WA%
			WinActivate, %WA%
		}Else  {
			WinMinimize, %WA%
            WinHide, %WA%
			; WinHide, WhatsApp Voip
			; WinHide, call ahk_exe WhatsApp.exe
		}
	}
Return

; !k::  
	; WinHide, % "ahk_id " (ID:=WinExist("A"))
	; WinSet, ExStyle, ^0x80, ahk_id %ID% ; Apply ToolWindow Style
	; WinShow, ahk_id %ID%
; Return


;----------------------------------------------------------------------------------------------------------------------
;Alt+I] Instagram
;----------------------------------------------------------------------------------------------------------------------
!i::
    IfWinNotExist, Instagram
    {
		IfWinActive, ahk_exe opera.exe
			Send, !i
		Else {
			SplashTextOn, 200, 25, Instagram, Press 'i' to open Instagram
			Input, SplashInput, T1 L1
			if (SplashInput = "i")
			{
				SoundBeep(6000, 100, 5)
				Run, "Z:\OneDrive\AHK\imports\Instagram_Edge.lnk"
				WinActivate, Instagram ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			}
			SplashTextOff
		}
    }
	Else
		BossKey("Instagram ahk_class Chrome_WidgetWin_1")
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Alt+M] MAL
;-----------------------------------------------------------------------------------------------------------------------
~!m::
	If WinActive("Mal-Sync - Opera")
		WinClose, Mal-Sync - Opera
    If !WinExist("MAL")
    {
		If (!WinActive("Your Default Browser's Title") AND !WinActive("Opera"))	;just detect whether ur browser or anime page is ActiveX
		{
			SplashTextOn, 200, 25, MAL, Press 'm' to open MAL
			Input, SplashInput, T1 L1
			if (SplashInput = "m")
			{
				SoundBeep(6000, 100, 5)
				Run, "Z:\OneDrive\AHK\imports\MAL_Edge.lnk"
				WinActivate, Instagram ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			}
			SplashTextOff
		}
    }
    Else
		BossKey("MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe")
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Shift+Alt+...] Opera Sidebar
;-----------------------------------------------------------------------------------------------------------------------
#If WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe")
+!m::	;------MAL------
	Click("-22", "610")		;-25, 740
	Click("32", "610")		;40, 740
Return
+!1::	;------GMAIL-0------
	Click("-22", "663")
	Click("32", "663")
Return
+!2::	;------GMAIL-1------
	Click("-22", "715")
	Click("32", "715")
Return
#If !WinActive("ahk_group game")


;-----------------------------------------------------------------------------------------------------------------------
;[Ctrl+Alt+S] Save Hotkeys.ahk
;-----------------------------------------------------------------------------------------------------------------------
^!s::
    IfWinActive,  %A_ScriptFullPath% - Notepad++
	{
		Send, ^s
		; SoundBeep(10000, 200, 5)
		WinActivate, ahk_class Shell_TrayWnd
		Reload		; Restart This script
	}Else {
		Send, ^!s
	}
Return
#If WinActive("- Notepad++")
^+!s::
	{
		IfWinNotExist, Window Spy ahk_exe AutoHotKey.exe
			Run, C:\Program Files\AutoHotkey\AutoHotkey.exe "C:\Program Files\AutoHotkey\WindowSpy.ahk"
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
;[Alt+.] Send ASCII character & Hotstrings
;-----------------------------------------------------------------------------------------------------------------------
; !.::
	; SoundBeep(6000, 110, 5)
	; Input, key, L6, LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}
	; str := key
	; For letter, number in {j: 1, k: 2, l: 3, u: 4, i: 5, o: 6, m: 0}
	; str := StrReplace(str, letter, number)
	; Send % str ~= "^\d+$" ? Format("{ASC {:0" StrLen(str) "}}", str) : key
	; SoundBeep(5000, 110, 5)
; Return

:o::lol::😂
:o::lmao::🤣
:o::sweat::😅
:o::exp::😑
:o::sad::😢
:o::cry::😢
:o::sob::😭
:o::smug::😏

:?*O:@/::@gmail.com


;-----------------------------------------------------------------------------------------------------------------------
;[Shift+F4] Network Monitor
;-----------------------------------------------------------------------------------------------------------------------
F1::
	If !WinExist("Drozd_net_monitor ahk_class AutoHotkeyGUI")
	{
		Run,  %A_ScriptDir%\Drozd_net_monitor\Drozd_net_monitor_original.exe
	}Else  {
		If WinActive("Drozd_net_monitor ahk_class AutoHotkeyGUI") and !WinActive("ahk_class Notepad++")
			Send, !{Tab}
		Else If !WinActive("Drozd_net_monitor ahk_class AutoHotkeyGUI") and !WinActive("ahk_class Notepad++")
			WinActivate Drozd_net_monitor ahk_class AutoHotkeyGUI
	}
	If WinActive("ahk_exe notepad++.exe")
		Send, {F1}
Return


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
	
	If ((A_ScreenWidth > 1600) AND (A_ScreenHeight > 900))
	{
		posx := posx / (A_ScreenWidth / 1600.0)
		posy := posy / (A_ScreenHeight / 900.0)
	} Else If ((A_ScreenWidth > 1600) AND (A_ScreenHeight > 900)) {
		posx := posx * (A_ScreenWidth / 1600.0)
		posy := posy * (A_ScreenHeight / 900.0)
	}
		
	If ((posx > 0) AND (posy > 890))
	{
		If WinActive("ahk_class Shell_TrayWnd")
			Send, !{Tab}
		Else
			WinActivate, ahk_class Shell_TrayWnd ahk_exe Explorer.EXE
	}
	Else If ((posx > 1450) AND (posy < 2))
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

#Include Include\Hotkeys__GenshinImpact.ahk
#Include Include\Hotkeys__Anime.ahk
#Include Include\Hotkeys__Spotify.ahk
#Include Include\Hotkeys__WSA.ahk
#Include Include\Hotkeys__BatteryAlarm.ahk


#If WinActive("ahk_class Windows.UI.Core.CoreWindow ahk_exe SearchHost.exe")	;--------SEARCH HOTSTRING------------------------------------------
:*O:A`;::Apps:
:*O:D`;::Documents:
:*O:F`;::Folder:
:*O:P`;::Photos:
:*O:V`;::Videos:
:*O:W`;::Web:
:*O:S`;::Settings:
:O:p/::paimon.moe/wish


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
	Send, !{Tab}
Else {
	WinActivate, ahk_class Shell_TrayWnd ahk_exe Explorer.EXE
	ControlFocus, Button2, ahk_class Shell_TrayWnd ahk_exe Explorer.EXE
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
		Run, "D:\MAL"
		SoundBeep(5000, 300, 5)
	}
	ELse If (SplashInput = "2")
	{
		Run, "Z:\DO_NOT_TOUCH\MEmu\Movies"
		SoundBeep(5000, 300, 5)
	}
	SplashTextOff
Return

^+!F6::			; Headphone sound Balance
	SoundGet, vol
	SoundSet, 10
	VA_SetMasterVolume("5", "2", "Headphone")
	SoundSet, vol
Return


;-------------------------------------------------------------------------------
; 4 Finger Wand
;-------------------------------------------------------------------------------
#^+F24::	;4 Finger Tap on touchpad
4FingerWand:
	CoordMode, Mouse, Screen
	MouseGetPos, posx, posy
	posx := posx * (A_ScreenWidth / 1920.0)
	posy := posy * (A_ScreenHeight / 1080.0)
	If ((posx > 1400) AND (posy > 200))		;Quick Settings		bottom-right-large
	{
		Sleep, 10
		Send, #a
	}
	Else If ((posx < 600) AND (posy > 200))	;SwitchDesktop		bottom-left-large
	{
		Sleep, 10
		SwitchDesktop()
	}
	Else If ((posx > 1850) AND (posy < 50))	;Edit This Script	top-right-small
	{
		Sleep, 10
		Goto, Edit_This_Script
	}
	Else If ((posx < 80) AND (posy < 50))	;Discord			top-left-small
	{
		Sleep, 10
		Goto, !d_Discord
	}
	Else	;Notification center
	{
		Sleep, 10
		If (WinActive("ahk_exe opera.exe") AND GetKeyState("RButton", "P"))
			Send, {RButton Down}{LButton}{RButton Up}
		Else
			Send, #n
	}
Return
#If !WinActive("ahk_group game")
~RButton & LButton Up::Goto, 4FingerWand
#If

^+!F3::Run, nircmd.exe changebrightness 20
^+!F2::Run, nircmd.exe changebrightness -20


;-------------------------------------------------------------------------------
; Switch Desktop
;-------------------------------------------------------------------------------
Global Desktop := 1	; Define 'Desktop' as a global variable to make it be able to be read in functions
SwitchDesktop(CharToSend:="", Window:="A",CharToSend2:="" , Window2:="A") {
	ControlSend, , %CharToSend%, %Window%
	If (Desktop = 1)
	{
		Send, #^{Right}
		Desktop := 2
	}Else {
		Send, #^{Left}
		Desktop := 1
	}	
	If WinExist(Window2)
		Sleep, 500
	If WinActive(Window2)
		Send, %CharToSend2%
}

+NumpadHome::
#d::SwitchDesktop()

~#^Left::Desktop := 1
~#^Right::Desktop := 2


;-------------------------------------------------------------------------------
;[End] Clear Notification & [F12] Process Hacker
;-------------------------------------------------------------------------------
~End & Home::
	Send, #n
	Sleep, 300
	Send, #n
Return

F12::
WinTitle := "ahk_class MainWindowClassName ahk_exe ProcessHacker.exe"
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


;-----------------------------------------------------------------------------------------------------------------------
