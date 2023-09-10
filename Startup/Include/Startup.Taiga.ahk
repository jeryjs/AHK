#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


title:="Taiga ahk_exe Taiga.exe"
path:="Z:\DO_NOT_TOUCH\Applications\Taiga\Taiga.exe"

Loop
{
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