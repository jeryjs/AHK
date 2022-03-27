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
#Warn
	
	
	
;/*--------------------------------------*\
;|----------VARIABLE-DEFINITIONS----------|
;\*--------------------------------------*/
Discord_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=magkoliahgffibhgfkmoealggombgknl --app-url=https://discord.com/channels/@me"
WhatsApp_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=hnpfjngllnobngcgfapefoaidbinmjnm --app-url=https://web.whatsapp.com/"
Instagram_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe --profile-directory=Default --app-id=maonlnecdeecdljpahhnnlmhbmalehlm --app-url=https://www.instagram.com/?theme=dark"
MAL_Edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe  --profile-directory=Default --app-id=gkpgichlplhgcfedjgdpjophefobmgag --app-url=https://myanimelist.net/?_location=homescreen"
	


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


;-----------------------------------------------------------------------------------------------------------------------
;[Alt+D] Opera - Discord
;-----------------------------------------------------------------------------------------------------------------------
!d::
    IfWinNotExist, Discord
    {
		IfWinNotActive, ahk_exe opera.exe
        {
			SplashTextOn, 150, 25, Discord, Open Discord First
			Sleep, 1000
			SplashTextOff
		}
        IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe	; Click Discord in the sidebar
        {
            CoordMode, Pixel, Window
            ImageSearch, FoundX, FoundY, 8, 8, 114, 624, *30 C:\Program Files\MacroCreator\Screenshots\Screen_20220226180438.png
            CenterImgSrchCoords("*30 C:\Program Files\MacroCreator\Screenshots\Screen_20220226180438.png", FoundX, FoundY)
            If ErrorLevel = 0
            Click, %FoundX%, %FoundY% Left, 1
            If ErrorLevel
            Loop, 2
            SoundBeep
			Sleep, 10
			Click, 440, 450, 0
        }
    }
    else  ; If exist
    {
        IfWinNotActive, Discord
		{
			Sleep, 100
            WinShow, Discord ahk_class Chrome_WidgetWin_1
            Sleep, 10
            WinActivate, Discord ahk_class Chrome_WidgetWin_1 ;ahk_exe Discord.exe
        }else  {
            WinHide, Discord ahk_class Chrome_WidgetWin_1
			Sleep, 10
			Send, {Alt down}{Esc}{Alt up}
        }
        Return
    }
Return
!+d::
	IfWinExist, Discord ahk_class AutoHotkey2
	{
		Run, %Discord_Edge%
		;Run, %A_Programs%\Discord
	}else  {
		Send, {Shift Down}{Alt Down}{d}{Alt Up}{Shift Up}
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
            SplashTextOn, 150, 25, WhatsApp, Open WhatsApp First
            Sleep, 1000
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
			Sleep, 100
			WinShow, WhatsApp ahk_class Chrome_WidgetWin_1
			Sleep, 300
			WinActivate, WhatsApp ahk_class Chrome_WidgetWin_1
		}else  {
			WinHide, WhatsApp ahk_class Chrome_WidgetWin_1
			Sleep, 10
			Send, {Alt down}{Esc}{Alt up}
		}
	}
Return
!+w::
	IfWinExist, WhatsApp ahk_class AutoHotkey2
	{
		Run, %WhatsApp_Edge%
	}else  {
		Send, {Shift Down}{Alt Down}{w}{Alt Up}{Shift Up}
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
            SplashTextOn, 150, 25, Instagram, Open Instagram First
            Sleep, 1000
            SplashTextOff
        }
		IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe
		{
			Send, {Alt Down}{i}{Alt Up}
		}
    }
    else  ;If exist
    {
		IfWinNotActive, Instagram
		{
			Sleep, 100
			WinShow, Instagram ahk_class Chrome_WidgetWin_1
			Sleep, 300
			WinActivate, Instagram ahk_class Chrome_WidgetWin_1
		}else  {
			WinHide, Instagram ahk_class Chrome_WidgetWin_1
			Sleep, 10
			Send, {Alt down}{Esc}{Alt up}
		}
	}
Return
!+i::
	IfWinExist, Instagram ahk_class AutoHotkey2
	{
		Run, %Instagram_Edge%
	}else  {
		Send, {Shift Down}{Alt Down}{i}{Alt Up}{Shift Up}
	}
Return
 

;-----------------------------------------------------------------------------------------------------------------------
;[Shift+Alt+M] Opera - MAL
;-----------------------------------------------------------------------------------------------------------------------
+!m::
    IfWinNotExist, MAL 
    {
        IfWinNotActive, ahk_exe opera.exe
        {
            SplashTextOn, 150, 25, MAL, Open MAL First
            Sleep, 1000
            SplashTextOff
        }
		IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe	;click mal in sidebar
		{
			CoordMode, Pixel, Window
			ImageSearch, FoundX, FoundY, 8, 378, 63, 775, *10 C:\Program Files\MacroCreator\Screenshots\Screen_20220209132854.png
			CenterImgSrchCoords("*10 C:\Program Files\MacroCreator\Screenshots\Screen_20220209132854.png", FoundX, FoundY)
			If ErrorLevel = 0
			Click, %FoundX%, %FoundY% Left, 1
			If ErrorLevel
			Loop, 2
			SoundBeep
			Sleep, 10
			Click, 440, 450, 0
		}
    }
    else  ;If exist
    {
		IfWinNotActive, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		{
			Sleep, 100
			WinShow, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			Sleep, 300
			WinActivate, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		}else  {
			WinHide, MAL ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
			Sleep, 10
			Send, {Alt down}{Esc}{Alt up}
		}
		
    }
Return
+m::
	IfWinExist, MAL ahk_class AutoHotkey2
	{
		Run, %MAL_Edge%
	}else  {
		Send, +m
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[`] Edge
;-----------------------------------------------------------------------------------------------------------------------
; `::
	; IfWinNotActive, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
	; {
		; WinGetTitle, Title, A
		; Sleep, 100
		; WinShow, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		; Sleep, 300
		; WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
	; }else  {
		; WinHide, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		; Sleep, 300
		; WinActivate, SMPlayer
		; Sleep, 300
		; IfWinActive, ahk_exe smplayer.exe 
		; { 
		; Send, {Space} 
		; }
	; }
	; IfWinNotExist, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe 
	; { 
	; Send, {`} 
	; }
; Return


;-----------------------------------------------------------------------------------------------------------------------
;[F12] Process Hacker
;-----------------------------------------------------------------------------------------------------------------------
F12::
    IfWinActive, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
	{
		Send, {Esc}
	}else {
		WinShow, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
		Sleep, 10
		WinActivate, ahk_class MainWindowClassName ahk_exe ProcessHacker.exe
	}
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Win+Alt+M] Send ASCII character
;-----------------------------------------------------------------------------------------------------------------------
#!m::
	SoundBeep, 1700
	Input, key, L4, {Enter}
	str := key
	For letter, number in {j: 1, k: 2, l: 3, u: 4, i: 5, o: 6, m: 0}
	 str := StrReplace(str, letter, number)
	Send % str ~= "^\d+$" ? Format("{ASC {:0" StrLen(str) "}}", str) : key
	SoundBeep, 1700
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Shift+F4] Network Monitor
;-----------------------------------------------------------------------------------------------------------------------
F4::
	IfWinNotExist Drozd_net_monitor ahk_class AutoHotkeyGUI
	{
		MsgBox, 4,, Do you want to start Drozd net monitor?, 5
			IfMsgBox No
				Return
				Else
				Run, Z:\Documents\AHK\Drozd_net_monitor\Drozd_net_monitor_original.exe
	}
	else  {
		IfWinActive Drozd_net_monitor ahk_class AutoHotkeyGUI
			Send, !{Esc}
			Else
			WinActivate Drozd_net_monitor ahk_class AutoHotkeyGUI
	}
	Send, {F4} 
Return


;-----------------------------------------------------------------------------------------------------------------------
;[Alt+Scroll] Adjust Volume by Alt + Scrolling Taskbar
;-----------------------------------------------------------------------------------------------------------------------
#If MouseIsOver("ahk_class Shell_TrayWnd")
	WheelUp::Send {Volume_Up}
	WheelDown::Send {Volume_Down}

MouseIsOver(WinTitle) 
	{
		MouseGetPos,,, Win
		return WinExist(WinTitle . " ahk_id " . Win)
	}
