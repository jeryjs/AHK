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
#UseHook
; #Warn All
#MaxHotkeysPerInterval 200
Menu, Tray, Icon, %A_ScriptDir%\imports\{Play with D-RPC`} VLC-Media-Player-icon.ico

; MsgBox, `%0`% = %0% `n `%1`% = %1% `n `%2`% = %2% `n `%3`% = %3% `n `%4`% = %4% `n `%5`% = %5% `n `%6`% = %6% `n `%7`% = %7% `n `%8`% = %8% `n `n Total = %1%%2%%3%%4% `n`n Whats this - %Folder_Path%

Run, Z:\DO_NOT_TOUCH\Applications\VLC\vlc.exe "%1%"
WinWait, ahk_exe vlc.exe, , 5


IfWinNotExist, Discord ahk_class Chrome_WidgetWin_1
{
	SplashTextOn, 150, 25,, Starting Discord
	Run, C:\Users\Jery\Desktop\Discord
	SplashTextOff
	WinWait, Discord, , 10
	WinHide
}
IfWinNotExist, npm ahk_class ConsoleWindowClass
{
	WinWait, Discord, , 20
	Run, Z:\Documents\vlc-discord-rpc\VLC D-rpc - start
	WinWait, npm ahk_class ConsoleWindowClass
	Sleep, 2000
	WinHide
	Send, !{Esc}
}
IfWinNotExist, .pmc - Pulover's Macro Creator v5.4.1
{
	SplashTextOn, 150, 25,, Starting MacroCreator
	Run, C:\Program Files\MacroCreator\MacroCreator.exe
	Send, ^!m
	SplashTextOff
	WinWait, ahk_exe MacroCreator.exe, , 10
	WinClose
}

; NumpadHome::
; If WinActive("VLC media player")
; {
	; WinHide, - VLC media player
	; WinActivate, ahk_class IEFrame
	; Click, -170 314, 1
	; WinShow, - VLC media player
	; WinActivate
; }Else {
	; Send, {Home}
; }
; Return


Reset_Loop:

; Last_Active_ID := Active_ID
; WinGet, Active_ID, ID, - VLC media player

Sleep, 1000

WinWaitClose, - VLC media player
; Goto, Update_MAL
Sleep, 1000
If ErrorLevel = 0
{
	IfWinNotExist, - VLC media player
	{
		WinShow, npm ahk_class ConsoleWindowClass
		WinActivate
	}Else {
		Goto, Reset_Loop
	}
}

ExitApp

!r::ExitApp



; !n::
; IfWinNotExist, ahk_exe iexplore.exe
; Else

; ie := ComObjCreate("InternetExplorer.Application")
; ie.Visible := true
; ie := ComObjConnect(InternetExplorer.Application, "IE")
; ie.Visible := true
; ie.Navigate("https://myanimelist.net/anime/263/")
; SoundBeep
; sleep, 10000
; ie.document.getElementsByClassName("fa-solid fa-circle-plus")[1].click()
; SoundBeep
; WinKill, ahk_exe iexplore.exe
; return








; !r::ExitApp

; ^!d::
    ; IfWinActive, Notepad++
	; {
		; Send, ^s
		; SoundBeep
		; Run, C:\Program Files\AutoHotkey\AutoHotkey.exe /restart "C:\Users\Jery\AppData\Local\Temp\20220402123759.ahk"
	; }else {
		; Send, ^!s
	; }
; Return

; !q::Return