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
; #Warn All
#MaxHotkeysPerInterval 200

menu, tray, add, Edit This Script, Edit_This_Script
menu, tray, Default, Edit This Script

StartTime := A_TickCount

; Double click tray icon to edit script 
Edit_This_Script:
If (StartTime > 120000)
	Run, "Z:\DO_NOT_TOUCH\Applications\Notepad++\notepad++.exe" %A_ScriptFullPath%
return

imag := "imag.*"
!l::
SplashImage, %A_ScriptDir%\images\Battery-Tan-665x245.jpg,b,
SoundPlay, %A_ScriptDir%\audios\Alarm02.wav
Sleep, 3000
SplashImage, Off
Return



;-----------------------------------------------------------------------------------------------------------------------
;[Ctrl+Alt+S] Save Hotkeys.ahk
;-----------------------------------------------------------------------------------------------------------------------
^!s::
    IfWinActive,  %A_ScriptFullPath% - Notepad++
	{
		Send, ^s
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
