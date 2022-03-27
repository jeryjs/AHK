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
Menu, Tray, Icon, Z:\Documents\AHK\imports\{Play with D-RPC`} VLC-Media-Player-icon.ico

; MsgBox, `%0`% = %0% `n `%1`% = %1% `n `%2`% = %2% `n `%3`% = %3% `n `%4`% = %4% `n `%5`% = %5% `n `%6`% = %6% `n `%7`% = %7% `n `%8`% = %8% `n `n Total = %1%%2%%3%%4% `n`n Whats this - %Folder_Path%

Run, E:\DO NOT TOUCH\Apps\VLC\vlc.exe "%1%"
WinWait, ahk_exe vlc.exe, , 5

MsgBox, 4164, VLC, Do you want to start the D-RPC Set?, 5	; 4+64+4096
; WinActivate AHK ahk_exe AutoHotkey.exe
IfMsgBox No
	ExitApp
Else {
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
        IfWinExist, Discord ahk_class Chrome_WidgetWin_1
		{
			Run, Z:\Documents\vlc-discord-rpc\VLC D-rpc - start
			WinWait, npm ahk_class ConsoleWindowClass
			Sleep, 2000
			WinHide
			Send, !{Esc}
        }
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
}


Reset_Loop:

; WinWait, - VLC media player
Sleep, 1000
WinWaitClose, - VLC media player
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