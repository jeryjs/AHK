#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance Force

Menu, Tray, Icon, C:\users\Jery\OneDrive\AHK\Hotkeys\imports\Discord.ico


SoundSet, 15
; Run, imports\Drozd_net_monitor_original.lnk,, Hide
Run, imports\server_win.lnk
; Run, imports\Hotkeys.ahk(elevated).lnk,,Hide
Run, Include\Startup.Discord.ahk
Run, Include\Startup.YouTube_Music.ahk
Run, Include\Startup.Taiga.ahk


ExitApp

` & Esc::ExitApp