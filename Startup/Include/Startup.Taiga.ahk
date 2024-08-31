#NoEnv
#SingleInstance, Force
DetectHiddenWindows, On
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


title:="Taiga ahk_exe Taiga.exe"
path:="Z:\Applications\Taiga\Taiga.exe"

Loop
{
    ; Check if Taiga is already running
    if WinExist("ahk_exe Taiga.exe")
    {
        ExitApp
    }

    If IsConnectedToInternet()
    {
        If !WinExist(title) 
        {
            Run, %path%,, Min
            WinWait, %title%,,10
            WinHide, %title%
        }
        ExitApp
    }
}
Return