#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
SetTitleMatchMode Fast
DetectHiddenWindows On
DetectHiddenText On
; #WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
#UseHook
#Persistent
#InstallKeybdHook
; KeyHistory
; #Warn All
#MaxHotkeysPerInterval 200
StartTime := A_TickCount

menu, tray, add, Edit This Script, Edit_This_Script
menu, tray, Default, Edit This Script

SetTimer, Battery_Check, 5000


; Double click tray icon to edit script 
Edit_This_Script:
EndTime := A_TickCount
If ((EndTime - StartTime) > 5000)
	Run, "Z:\DO_NOT_TOUCH\Applications\Notepad++\notepad++.exe" %A_ScriptFullPath%
return

; Open VLC from Tray
Open_VLC_Tray()
{
WinActivate,  ahk_class NotifyIconOverflowWindow
ControlFocus, ToolbarWindow321, ahk_class NotifyIconOverflowWindow
; ControlSend, ToolbarWindow321, {Right}, ahk_class NotifyIconOverflowWindow	;;UnComment this if VLC is the 2nd icon in system tray
ControlSend, ToolbarWindow321, {Enter}, ahk_class NotifyIconOverflowWindow
SendEvent, {Click, 1363, 498, 0}
WinWaitActive, ahk_exe vlc.exe, , 5
Send, {Space}
}

; Custom SoundBeep
SoundBeep(Frequency, Duration, Volume) {
    SoundGet, MasterVolume
    SoundSet, Volume
	Sleep, 300
    SoundBeep, Frequency, Duration
    SoundSet, MasterVolume
}


; #If WinActive("Nox")
; `::
; End::
; MButton::
	; Click, 690, 620, 1
	; Send, !x
	; WinActivate, SMPlayer
	; Send, {Space}
; Return

#If !WinActive("Genshin Impact ahk_exe GenshinImpact.exe") ; !WinActive("Nox")
;-----------------------------------------------------------------------------------------------------------------------
;[Alt+D] Opera - Discord
;-----------------------------------------------------------------------------------------------------------------------
!d::
!d_Discord:
    IfWinNotExist, Discord
    {
		SplashTextOn, 200, 25, Discord, Press 'd' to open Discord
		Input, SplashInput, T1 L1
		If (SplashInput = "d")
		{
			SoundBeep(6000, 100, 5)
			Run, C:\Users\Jery\AppData\Local\Discord\app-1.0.9004\Discord.exe
			WinActivate, Discord ahk_exe Discord.exe
		}
		SplashTextOff
    }
    Else 
    {
        IfWinNotActive, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
		{
            WinShow, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
            WinActivate, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
        }Else  {
            WinHide, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
			Send, !{Tab}
			; Send, +!{Tab}
			WinActivate, Genshin Impact
        }
    }
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Alt+W] WhatsApp
;-----------------------------------------------------------------------------------------------------------------------
!w::
    IfWinNotExist, WhatsApp
    {
		SplashTextOn, 200, 25, WhatsApp, Press 'w' to open WhatsApp
		Input, SplashInput, T1 L1
		if (SplashInput = "w")
		{
			SoundBeep(6000, 100, 5)
			Run, "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\WhatsApp"
			WinActivate, WhatsApp ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		}
		SplashTextOff
	}
    Else 
    {
		IfWinNotActive, WhatsApp 
		{
			WinClose, WhatsApp Voip
			WinClose, call ahk_exe WhatsApp.exe
			WinShow, WhatsApp ahk_exe WhatsApp.exe
			WinActivate, WhatsApp ahk_exe WhatsApp.exe
		}Else  {
			WinHide, WhatsApp ahk_exe WhatsApp.exe
			Send, !{Tab}
		}
	}
Return


;----------------------------------------------------------------------------------------------------------------------
;Alt+I] Instagram
;----------------------------------------------------------------------------------------------------------------------
!i::
    IfWinNotExist, Instagram
    {
		SplashTextOn, 200, 25, Instagram, Press 'i' to open Instagram
		Input, SplashInput, T1 L1
		if (SplashInput = "i")
		{
			SoundBeep(6000, 100, 5)
			Run, "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Instagram Edge"
			WinActivate, Instagram ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		}
		SplashTextOff
    }
    Else 
    {
		IfWinNotActive, Instagram
		{
			WinShow, Instagram ahk_class Chrome_WidgetWin_1
			WinActivate, Instagram ahk_class Chrome_WidgetWin_1
		}Else  {
			WinHide, Instagram ahk_class Chrome_WidgetWin_1
			Send, !{Tab}
		}
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Alt+M] Opera - MAL
;-----------------------------------------------------------------------------------------------------------------------
!m::
    If !WinExist("MAL")
    {
		SplashTextOn, 200, 25, MAL, Press 'm' to open MAL
		Input, SplashInput, T1 L1
		if (SplashInput = "m")
		{
			SoundBeep(6000, 100, 5)
			Run, "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\MAL Edge"
			WinActivate, Instagram ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		}
		SplashTextOff
    }
    Else
    {
		IfWinNotActive, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		{
			WinShow, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			WinActivate, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		}Else  {
			WinHide, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			Send, !{Tab}
		}
    }
Return
+!m::
	IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe
	{
		Click, -22 610		;-25, 740
		Click, 	32 610		;40, 740
	}Else  {
		Send, +!m
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[F12] Process Hacker
;-----------------------------------------------------------------------------------------------------------------------
F12::
    IfWinActive, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
	{
		WinHide, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
		Send, !{Tab}
	}Else {
		WinShow, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
		WinActivate, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
		Send, ^k
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Ctrl+Alt+S] Save Hotkeys.ahk
;-----------------------------------------------------------------------------------------------------------------------
^!s::
    IfWinActive,  %A_ScriptFullPath% - Notepad++
	{
		Send, ^s
		SoundBeep(10000, 200, 5)
		Reload		; Restart This script
	}Else {
		Send, ^!s
	}
Return
^+!s::
	IfWinActive, - Notepad++
	{
		IfWinNotExist, Window Spy ahk_exe AutoHotKey.exe
			Run, C:\Program Files\AutoHotkey\AutoHotkey.exe "C:\Program Files\AutoHotkey\WindowSpy.ahk"
		Else
			WinClose, Window Spy ahk_exe AutoHotKey.exe
	}
	Send, ^+!s
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Alt+.] Send ASCII character
;-----------------------------------------------------------------------------------------------------------------------
!.::
	SoundBeep(6000, 110, 7)
	Input, key, L6, LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}
	str := key
	For letter, number in {j: 1, k: 2, l: 3, u: 4, i: 5, o: 6, m: 0}
	str := StrReplace(str, letter, number)
	Send % str ~= "^\d+$" ? Format("{ASC {:0" StrLen(str) "}}", str) : key
	SoundBeep(5000, 110, 20)
Return

:::lol::😂
:::lmao::🤣
:::sweat::😅
:::sad::😢
:::cry::😭


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
; Turn off NumLock & CapsLock
;-------------------------------------------------------------------------------
~NumLock::
	Sleep, 60000	;1 min
	SetCapsLockState, Off
	SoundBeep(3000, 100, 5)
Return

~CapsLock::
	Sleep, 60000	;1 min
	SetCapsLockState, Off
	SoundBeep(3000, 100, 5)
Return


;-------------------------------------------------------------------------------
; Remaps
;-------------------------------------------------------------------------------

#If WinActive("ahk_exe mpvnet.exe")	;---------MPV NET-------------------------------------
NumpadPgUp::Send {PgUp}
+NumpadPgUp::Send +{PgUp}
NumpadPgDn::Send {PgDn}
+NumpadPgDn::Send +{PgDn}
NumpadClear::Send {Numpad5}
NumpadRight::Send, {Right}
NumpadLeft::Send, {Left}
NumpadUp::Send, {Up}
NumpadDown::Send, {Down}
!t::Run, "Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe" 


#If WinActive("ahk_exe vlc.exe")	;---------VLC MEDIA PLAYER----------------------------------------
NumpadPgUp::Send +{Right}
NumpadClear::Send +{Left}
NumpadPgDn::Send {/}
+NumpadPgDn::Send +{/}
!t::Run, Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe

#If WinExist("ahk_exe vlc.exe")
+NumpadHome::
!F6::Open_VLC_Tray()


#If WinActive("- AniMixPlay")	;----------ANIMIXPLAY-----------------------------
NumpadPgDn::Send {/}
+NumpadPgDn::Send +{/}
!t::Run, Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe

NumpadHome::
	Click, 1260 800 ;828		;1517 957
	Sleep, 700
	Click, 1260 708 ;738		;1480 900
	Sleep, 500
	Click, 1260 708 ;728		;1480 700
	Sleep, 300
	Click, 1260	500		;993 631
	Click, 1260 500		;993 631
Return
	

#If WinActive("Taiga ahk_exe Taiga.exe")	;-----------TAIGA-------------------------
NumpadEnter::
	Send, {Enter}
	Sleep, 300
	Send, !{Tab}
	; WinActivate, ahk_class Qt5QWindowIcon	;VLC
	; Click, 580 730, 1
Return
!t::WinClose, Taiga ahk_class TaigaMainW

#If WinExist("Taiga ahk_exe Taiga.exe") OR WinActive("ahk_class WorkerW ahk_exe explorer.exe")
!t::Run, Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe


#If WinActive("Genshin Impact ahk_exe GenshinImpact.exe")	  ;---------GENSHIN IMPACT-------------------------
CoordMode, Mouse, Screen
/::
	Send, {/}
	Sleep, 200
	Click, 640, 830		;800, 1000
	Sleep, 300
	Click, 640, 830		;800, 1000
Return
MButton::
	Send, {AltDown}
	Sleep, 200
	Click, 230, 33		;278, 42
	Sleep, 200
	; Send, {Ctrl}
	Send, {AltUp}
Return
!d::GoTo, !d_Discord
RCtrl::Send, {LButton}


#If WinActive("Search ahk_exe SearchHost.exe")	;--------SEARCH HOTSTRING------------------------------------------
::A`;::Apps:
::D`;::Documents:
::F`;::Folder:
::P`;::Photos:
::V`;::Videos:
::W`;::Web:
::S`;::Settings:


#If	;-------NORMAL-----------------------------------------------------------
NumpadIns::Send {Space}
#o::Send, #3
+!a::Run, Z:\DO_NOT_TOUCH\MEmu\MAL
!F11::Run, "Z:\DO_NOT_TOUCH\Applications\IObit\ScreenShot.exe"

#d::
	If (Desktop = 1)
	{
		Send, #^{Right}
		Desktop := 2
		; WinActivate, Genshin Impact ahk_class UnityWndClass
	}Else {
		IfWinActive, Genshin Impact ahk_class UnityWndClass ahk_exe GenshinImpact.exe
		{
			Send, {Esc}
			SoundSet, 0
		}
		Send, #^{Left}
		Desktop := 1
	}
Return
~#^Left::Desktop := 1
~#^Right::Desktop := 2

^+!F3::Run, nircmd.exe changebrightness 20
^+!F2::Run, nircmd.exe changebrightness -20

; #c::	; CORTANA-----------------------------------------------------------
	; If !WinExist("Cortana ahk_exe ApplicationFrameHost.exe")
		; Run, "C:\Program Files\WindowsApps\Microsoft.549981C3F5F10_4.2203.4603.0_x64__8wekyb3d8bbwe\Cortana.exe" -ServerName:App.AppX2y379sjp88wjq1y80217mddj3fargf2y.mca
	; If !WinActive("Cortana ahk_exe ApplicationFrameHost.exe")
	; {
		; WinActivate, Cortana ahk_exe ApplicationFrameHost.exe
		; WinWaitActive, Cortana ahk_exe ApplicationFrameHost.exe
		; Sleep, 300
		; Click 513, 805	; 691, 945
	; }Else 
		; Click 513, 805	; 691, 945		
; Return
; ~Esc::
	; WinClose, Cortana ahk_exe ApplicationFrameHost.exe
	; sLeep 1000
	; WinKill, Cortana
; Return
; #f::Send, #g












; Shimanov's Read Integer Function
ReadInteger( p_address, p_offset, p_size, p_hex=true )
{
  value = 0
  old_FormatInteger := a_FormatInteger
  if ( p_hex )
    SetFormat, integer, hex
  Else
    SetFormat, integer, dec
  loop, %p_size%
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
  SetFormat, integer, %old_FormatInteger%
  return, value
}

; Battery Alarm
Battery_Tan_Success := 0
Battery_Check:
	VarSetCapacity(powerstatus, 1+1+1+1+4+4)
	success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)
	
	AC_Status:=ReadInteger(&powerstatus,0,1,false)
	Battery_Life:=ReadInteger(&powerstatus,2,1,false)
	; msgbox, %AC_Status%
	If ((Battery_Tan_Success < 2) AND ( ((AC_Status = 1) AND (Battery_Life = 80)) OR ((AC_Status = 0) AND (Battery_Life = 40)) ) )
	{
		; SoundGet, currentvolume
		; SoundSet, 30
		SoundPlay, %A_ScriptDir%\audios\Alarm02.wav
		IfWinNotActive, Genshin Impact ahk_class UnityWndClass
			SplashImage, %A_ScriptDir%\images\Battery-Tan-665x245.jpg,b,
		Sleep, 3000
		SplashImage, Off
		; SoundSet, currentvolume
		Battery_Tan_Success++
	}
	Else If ((Battery_Tan_Success = 2) AND ( ((Battery_Life = 81) OR (Battery_Life = 79)) OR ((Battery_Life = 41) OR (Battery_Life = 39)) ) )
		Battery_Tan_Success := 0
Return





