﻿#NoEnv
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
; #Warn All
#MaxHotkeysPerInterval 200

menu, tray, add, Edit This Script, Edit_This_Script
menu, tray, Default, Edit This Script



;/*--------------------------------------*\
;|----------VARIABLE-DEFINITIONS----------|
;\*--------------------------------------*/
; Discord_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=magkoliahgffibhgfkmoealggombgknl --app-url=https://discord.com/channels/@me"
; WhatsApp_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=hnpfjngllnobngcgfapefoaidbinmjnm --app-url=https://web.whatsapp.com/"
; Instagram_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe --profile-directory=Default --app-id=maonlnecdeecdljpahhnnlmhbmalehlm --app-url=https://www.instagram.com/?theme=dark"
; MAL_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=gkpgichlplhgcfedjgdpjophefobmgag --app-url=https://myanimelist.net/?_location=homescreen"

Discord_Edge := "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Edge"
WhatsApp_Edge := "C:\Users\Jery\AppData\Local\WhatsApp\WhatsApp.exe"
WhatsApp := "C:\Program Files\WindowsApps\5319275A.WhatsAppDesktop_2.2210.10.0_x64__cv1g1gvanyjgm\app\WhatsApp.exe" 
Instagram_Edge := "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Instagram Edge"
MAL_Edge := "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\MAL Edge"
StartTime := A_TickCount

; Double click tray icon to edit script 
Edit_This_Script:
If (StartTime > 60000)
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
    SoundBeep, Frequency, Duration
    SoundSet, MasterVolume
}

; Reload This script once in 10 mins
SetTimer, ReloadHotKeys, 600000
Return
ReloadHotKeys:
Run, C:\Program Files\AutoHotkey\AutoHotkey.exe /restart " %A_ScriptFullPath%"
Return

; shimanov's Read Integer Function
ReadInteger( p_address, p_offset, p_size, p_hex=true )
{
  value = 0
  old_FormatInteger := a_FormatInteger
  if ( p_hex )
    SetFormat, integer, hex
  else
    SetFormat, integer, dec
  loop, %p_size%
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
  SetFormat, integer, %old_FormatInteger%
  return, value
}

; Battery Alarm
SetTimer, Battery_Check, 2000
Return
Battery_Check:
msgbox yay
	; VarSetCapacity(powerstatus, 1+1+1+1+4+4)
	; success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)

	; AC_Status:=ReadInteger(&powerstatus,0,1,false)
	; Battery_Life:=ReadInteger(&powerstatus,2,1,false)
	; msgbox, %AC_Status%
	; If ((AC_Status = 1) AND (Battery_Life = 80)) OR ((AC_Status = 0) AND (Battery_Life = 40))
	; {
		SoundPlay, %A_WinDir%\WinSxS\amd64_microsoft-windows-shell-sounds_31bf3856ad364e35_10.0.22593.1_none_7678216cac587112\Ring06.wav	; Ring06.wav
		; SoundPlay, %A_WinDir%\WinSxS\amd64_microsoft-windows-shell-sounds_31bf3856ad364e35_10.0.22593.1_none_7678216cac587112\Alarm02.wav
		; SplashImage, Z:\Documents\AHK\images\Battery-Tan-665x245.jpg,b,
		; Sleep, 3000
		; SplashImage, Off
	; }	
Return


#If WinActive("Nox")
`::
End::
MButton::
	Click, 690, 620, 1
	Send, !x
	WinActivate, SMPlayer
	Send, {Space}
Return

#If !WinActive("Nox")
;-----------------------------------------------------------------------------------------------------------------------
;[Alt+D] Opera - Discord
;-----------------------------------------------------------------------------------------------------------------------
!d::
    IfWinNotExist, Discord
    {
		IfWinNotActive, ahk_exe opera.exe
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
        IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe
        {
            Click, 27 351
        }
		Send, !d
    }
    else  ; If exist
    {
        IfWinNotActive, Discord
		{
            WinShow, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
            WinActivate, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
        }else  {
            WinHide, Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
			Send, {Alt down}{Esc}{Alt up}
        }
    }
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Alt+W] WhatsApp
;-----------------------------------------------------------------------------------------------------------------------
!w::
    IfWinNotExist, WhatsApp
    {
        IfWinNotActive, ahk_exe opera.exe
        {
            SplashTextOn, 200, 25, WhatsApp, Press 'w' to open WhatsApp
			Input, SplashInput, T1 L1
			if (SplashInput = "w")
			{
				SoundBeep(6000, 100, 5)
				Run, %WhatsApp%
				WinActivate, WhatsApp ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			}
            SplashTextOff
        }
		IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe
		{
			Send, {Alt Down}{w}{Alt Up}
		}
	}
    else  ;If exist
    {
		IfWinNotActive, WhatsApp 
		{
			WinClose, WhatsApp Voip
			WinShow, WhatsApp ahk_exe WhatsApp.exe
			WinActivate, WhatsApp ahk_exe WhatsApp.exe
		}else  {
			WinHide, WhatsApp ahk_exe WhatsApp.exe
			Send, {Alt down}{Esc}{Alt up}
		}
	}
Return


;----------------------------------------------------------------------------------------------------------------------
;Alt+I] Instagram
;----------------------------------------------------------------------------------------------------------------------
!i::
    IfWinNotExist, Instagram
    {
        IfWinNotActive, ahk_exe opera.exe
        {
            SplashTextOn, 200, 25, Instagram, Press 'i' to open Instagram
			Input, SplashInput, T1 L1
			if (SplashInput = "i")
			{
				SoundBeep(6000, 100, 5)
				Run, %Instagram_Edge%
				WinActivate, Instagram ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			}
            SplashTextOff
        }
		IfWinActive, ;ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe
		{
			Send, {Alt Down}{i}{Alt Up}
		}
    }
    else  ;If exist
    {
		IfWinNotActive, Instagram
		{
			WinShow, Instagram ahk_class Chrome_WidgetWin_1
			WinActivate, Instagram ahk_class Chrome_WidgetWin_1
		}else  {
			WinHide, Instagram ahk_class Chrome_WidgetWin_1
			Send, {Alt down}{Esc}{Alt up}
		}
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Alt+M] Opera - MAL
;-----------------------------------------------------------------------------------------------------------------------
!m::
    IfWinNotExist, MAL
    {
        IfWinNotActive, ahk_exe opera.exe
        {
            SplashTextOn, 200, 25, MAL, Press 'm' to open MAL
			Input, SplashInput, T1 L1
			if (SplashInput = "m")
			{
				SoundBeep(6000, 100, 5)
				Run, %MAL_Edge%
				WinActivate, Instagram ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			}
            SplashTextOff
        }else  {
		Send, !m
		}
    }
    else  ;If exist
    {
		IfWinNotActive, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		{
			WinShow, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			WinActivate, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		}else  {
			WinHide, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			Send, {Alt down}{Esc}{Alt up}
		}
    }
Return
+!m::
	IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe
	{
		Click, -25, 740
		Click, 40, 740
	}else  {
		Send, +!m
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[`] Edge
;-----------------------------------------------------------------------------------------------------------------------
^`::
	IfWinNotActive, Profile 1 - Microsoft​ Edge ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
	{
		WinShow, Profile 1 - Microsoft​ Edge ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		WinActivate, Profile 1 - Microsoft​ Edge ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
	}else  {
		WinHide, Profile 1 - Microsoft​ Edge ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		WinActivate, - SMPlayer
		Sleep 100
		Click, 27 532
		Send, {Space}
	}
	IfWinNotExist, Profile 1 - Microsoft​ Edge ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
	{
	Send, {`}
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[F12] Process Hacker
;-----------------------------------------------------------------------------------------------------------------------
F12::
    IfWinActive, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
	{
		WinHide, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
		Send, {Alt down}{Esc}{Alt up}
	}else {
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
		Run, C:\Program Files\AutoHotkey\AutoHotkey.exe /restart "%A_ScriptFullPath%"
	}else {
		Send, ^!s
	}
Return
^+!s::
	IfWinActive, - Notepad++
	{
		IfWinNotExist, Window Spy ahk_exe AutoHotKey.exe
			Run, C:\Program Files\AutoHotkey\AutoHotkey.exe "C:\Program Files\AutoHotkey\WindowSpy.ahk"
		else
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
:::sweat::😌
:::sad::😢
:::cry::😭


;-----------------------------------------------------------------------------------------------------------------------
;[Shift+F4] Network Monitor
;-----------------------------------------------------------------------------------------------------------------------
F6::
	IfWinNotExist Drozd_net_monitor ahk_class AutoHotkeyGUI
	{
		Run,  %A_ScriptDir%\Drozd_net_monitor\Drozd_net_monitor_original.exe
	}else  {
		IfWinActive Drozd_net_monitor ahk_class AutoHotkeyGUI
			Send, !{Esc}
		Else
			WinActivate Drozd_net_monitor ahk_class AutoHotkeyGUI
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Scroll] Adjust Volume & Brightness By Scrolling Over Taskbar
;-----------------------------------------------------------------------------------------------------------------------
; #If over("Shell_TrayWnd")
	; WheelUp::Send {Volume_Up}
	; WheelDown::Send {Volume_Down}
	; MButton::Send {Volume_Mute}

	; RButton & WheelUp::Run, C:\Windows\System32\nircmd.exe changebrightness 10
	; RButton & WheelDown::Run, C:\Windows\System32\nircmd.exe changebrightness -10
	; RButton::RButton
; #If

; over(class) {
	 ; MouseGetPos,x,y, uid
	 ; WinGetClass, thisClass, ahk_id %uid%
	 ; Return thisClass = class
; }

; RButton & LButton::
; LButton & RButton::Send, {MButton}


;-------------------------------------------------------------------------------
; Change Theme
;-------------------------------------------------------------------------------
; #>!PgUp::
	; RegRead, Current_Theme, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes, CurrentTheme
	; If (Current_Theme = "C:\Users\Jery\AppData\Local\Microsoft\Windows\Themes\Default Blu.theme")
		; Run, C:\Windows\Resources\Themes\Windows 11 Dark  ThemeA.theme
	; Else
		; Run, C:\Users\Jery\AppData\Local\Microsoft\Windows\Themes\Default Blu.theme
	; WinWait, Control Panel\Appearance and Personalisation\Personalisation, , 10
	; Sleep 3000
	; WinClose
; Return


;-------------------------------------------------------------------------------
; Remaps
;-------------------------------------------------------------------------------
#If WinActive(".mp4 - mpv.net")
NumpadPgUp::Send {PgUp}
+NumpadPgUp::Send +{PgUp}
NumpadPgDn::Send {PgDn}
+NumpadPgDn::Send +{PgDn}
NumpadClear::Send {Numpad5}

#If WinActive("- VLC media player")
NumpadPgUp::Send +{Right}
NumpadClear::Send +{Left}
NumpadPgDn::Send {/}
+NumpadPgDn::Send +{/}
!t::Run, Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe

#If WinActive("- AniMixPlay")
NumpadPgDn::Send {/}
+NumpadPgDn::Send +{/}
!t::Run, Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe

NumpadHome::
	Click, 1517 957
	Sleep, 700
	Click, 1480 900
	Sleep, 500
	Click, 1480 700
	Sleep, 300
	Click, 993 631
	Click, 993 631
Return
	

#If WinExist("- VLC media player")
+NumpadHome::
!F6::Open_VLC_Tray()

#If WinExist("Taiga ahk_class #32770")
NumpadEnter::
	Send, {Enter}
	Sleep, 300
	WinActivate, ahk_class Qt5QWindowIcon	;VLC
	; Click, 580 730, 1
Return

#If
NumpadIns::Send {Space}
#o::Send, #3
+!a::Run, Z:\DO_NOT_TOUCH\MEmu\MAL

; #d::Send, #^{Right}

#c::
	Run, C:\Program Files\WindowsApps\Microsoft.549981C3F5F10_4.2203.4603.0_x64__8wekyb3d8bbwe\Cortana.exe
	Sleep, 1200
	WinActivate, Cortana
	Click 691, 945
Return
~Esc::
	WinClose, Cortana
	sLeep 1000
	WinKill, Cortana
Return