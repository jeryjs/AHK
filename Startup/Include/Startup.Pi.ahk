;-----------------------------------------------------------------------------------
; Startup: Pi Agent Terminal
;-----------------------------------------------------------------------------------
; Launches the fullscreen "Pi Agent" terminal at logon and parks it on virtual
; desktop #1. Your own logon desktop (#2 or #3) is left exactly as it was.
;-----------------------------------------------------------------------------------
#NoEnv
#SingleInstance Force
DetectHiddenWindows On
SetTitleMatchMode 2
#include %A_ScriptDir%\..\..\Lib\_VD.ahk

VD.init()

PiTitle      := "PiAgentScratch-7f3a"
PiDesktopNum := 1
PiWorkingDir := "C:\Users\Jery\OneDrive\Desktop"
PiBin        := "C:\Users\Jery\.pi\agent\bin\pi.cmd"
PiProfile    := "Pi Agent"

; Explorer may still be restoring virtual desktops right after logon
Sleep, 5000

; Remember what had focus so we can hand it straight back: the terminal window we
; spawn must never end up focused, otherwise it yanks you off your own desktop.
FgHwnd := WinExist("A")

Run, wt.exe -F -w new new-tab -p "%PiProfile%" --title "%PiTitle%" --suppressApplicationTitle -d "%PiWorkingDir%" "%PiBin%" --no-session
WinWait, %PiTitle%, , 25
if !ErrorLevel {
    ; Move it onto desktop #1 as fast as possible so it never flashes on the
    ; desktop you actually work on. Moving a window never switches desktops.
    Loop 8 {
        VD.MoveWindowToDesktopNum(PiTitle, PiDesktopNum)
        Sleep, 120
    }
}

; Give focus straight back to whatever owned it before we spawned anything.
if (FgHwnd && WinExist("ahk_id " FgHwnd))
WinActivate, ahk_id %FgHwnd%

ExitApp
