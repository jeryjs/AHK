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
#Warn All
#MaxHotkeysPerInterval 200



;/*--------------------------------------*\
;|----------VARIABLE-DEFINITIONS----------|
;\*--------------------------------------*/
; Discord_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=magkoliahgffibhgfkmoealggombgknl --app-url=https://discord.com/channels/@me"
; WhatsApp_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=hnpfjngllnobngcgfapefoaidbinmjnm --app-url=https://web.whatsapp.com/"
; Instagram_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe --profile-directory=Default --app-id=maonlnecdeecdljpahhnnlmhbmalehlm --app-url=https://www.instagram.com/?theme=dark"
; MAL_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=gkpgichlplhgcfedjgdpjophefobmgag --app-url=https://myanimelist.net/?_location=homescreen"

Discord_Edge := "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Edge"
WhatsApp_Edge := "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\WhatsApp Edge"
Instagram_Edge := "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Instagram"
MAL_Edge := "C:\Users\Jery\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\MAL"



CenterImgSrchCoords(File, ByRef CoordX, ByRef CoordY)
{
	static LoadedPic
	LastEL := ErrorLevel

	Gui, Pict:Add, Pic, vLoadedPic, % RegExReplace(File, "^(\*\w+\s)+")
	GuiControlGet, LoadedPic, Pict:Pos
	Gui, Pict:Destroy
	CoordX += LoadedPicW // 2
	CoordY += LoadedPicH // 2
	ErrorLevel := LastEL
}

;-------------------------------------------------------------------------------
SoundBeep(Frequency, Duration, Volume) { ; custom wrapper
;-------------------------------------------------------------------------------
    SoundGet, MasterVolume
    SoundSet, Volume
    SoundBeep, Frequency, Duration
    SoundSet, MasterVolume
}


; Reload This AHK once in 10 mins
SetTimer, ReloadHotKeys, 600000
Return
ReloadHotKeys: 
Run, C:\Program Files\AutoHotkey\AutoHotkey.exe /restart "Z:\Documents\AHK\Hotkeys.ahk"
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
			if (SplashInput = "d")
			{
				SoundBeep(6000, 100, 20)
				Run, %Discord_Edge%
				WinActivate, Discord ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			}
			If (SplashInput = "e")
			{
				SoundBeep(6000, 100, 20)
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
				SoundBeep(6000, 100, 20)
				Run, %WhatsApp_Edge%
				WinActivate, WhatsApp ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			}
            SplashTextOff
        }
		IfWinActive, ;ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe
		{
			Send, {Alt Down}{w}{Alt Up}
		}
	}
    else  ;If exist
    {
		IfWinNotActive, WhatsApp
		{
			WinShow, WhatsApp ahk_class Chrome_WidgetWin_1
			WinActivate, WhatsApp ahk_class Chrome_WidgetWin_1
		}else  {
			WinHide, WhatsApp ahk_class Chrome_WidgetWin_1
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
				SoundBeep(6000, 100, 20)
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
;[Shift+Alt+M] Opera - MAL
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
				SoundBeep(6000, 100, 20)
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
		Click, 27 532
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
		Send, {Esc}
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
    IfWinActive, Z:\Documents\AHK\Hotkeys.ahk - Notepad++
	{
		Send, ^s
		SoundBeep(10000, 200, 15)
		Run, C:\Program Files\AutoHotkey\AutoHotkey.exe /restart "Z:\Documents\AHK\Hotkeys.ahk"
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
	SoundBeep(6000, 110, 20)
	Input, key, L6, LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}
	str := key
	For letter, number in {j: 1, k: 2, l: 3, u: 4, i: 5, o: 6, m: 0}
	str := StrReplace(str, letter, number)
	Send % str ~= "^\d+$" ? Format("{ASC {:0" StrLen(str) "}}", str) : key
	SoundBeep(5000, 110, 20)
Return

#.::
	Run, TabTip.exe
	IfWinExist ahk_exe TabTip.exe
	{
		Sleep, 200
		Click, 414 734, 1
		Click, 580 730, 1
	}
Return

:::lol::😂
:::sweat::😌
:::sad::😢
:::cry::😭


;-----------------------------------------------------------------------------------------------------------------------
;[Shift+F4] Network Monitor
;-----------------------------------------------------------------------------------------------------------------------
F4::
	IfWinNotExist Drozd_net_monitor ahk_class AutoHotkeyGUI
	{
		MsgBox, 4,, Do you want to start Drozd net monitor?, 4
		IfMsgBox No
			Return
		Else
			Run, Z:\Documents\AHK\Drozd_net_monitor\Drozd_net_monitor_original.exe
	}else  {
		IfWinActive Drozd_net_monitor ahk_class AutoHotkeyGUI
			Send, !{Esc}
		Else
			WinActivate Drozd_net_monitor ahk_class AutoHotkeyGUI
	}
	Send, {F4}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Scroll] Adjust Volume & Brightness By Scrolling Over Taskbar
;-----------------------------------------------------------------------------------------------------------------------
#If over("Shell_TrayWnd")
	WheelUp::Send {Volume_Up}
	WheelDown::Send {Volume_Down}
	MButton::Send {Volume_Mute}
	
	RButton & WheelUp::Run, C:\Windows\System32\nircmd.exe changebrightness 5
	RButton & WheelDown::Run, C:\Windows\System32\nircmd.exe changebrightness -5
	RButton::RButton
#If

over(class) {
	 MouseGetPos,x,y, uid
	 WinGetClass, thisClass, ahk_id %uid%
	 Return thisClass = class
}


;Fix cmd 'ctrl+v'
^v::
IfWinActive ahk_exe cmd.exe
	Sendinput, {RButton}
	Else Send, ^v
Return


;Change Theme
#>!PgUp::
	; Run, C:\Windows\Resources\Themes\Windows 11 light ThemeD.theme
	Run, C:\Users\Jery\AppData\Local\Microsoft\Windows\Themes\Default Blu.theme
	WinWait, Control Panel\Appearance and Personalisation\Personalisation, , 10
	Sleep 3000
	WinClose
Return
#>!PgDn::
	Run, C:\Windows\Resources\Themes\Windows 11 Dark  ThemeA.theme
	WinWait, Control Panel\Appearance and Personalisation\Personalisation, , 10
	Sleep 5000
	Run, C:\Windows\Resources\Themes\Royex.theme
	WinWait, Control Panel\Appearance and Personalisation\Personalisation, , 10
	Sleep 3000
	WinClose
Return



; Sleep 2000
; Run, nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 1
; Sleep 2000
; Run, C:\Windows\System32\nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 0