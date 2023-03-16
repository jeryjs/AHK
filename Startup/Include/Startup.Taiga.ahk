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
    If ConnectedToInternet()
    {
        If !WinExist(title) 
        {
            Run, %path%,, Min
            WinWait, %title%,,10
            WinHide, %title%
        }
        ExitApp
    }
    ConnectedToInternet(flag=0x43)
    {
        Return DllCall("Wininet.dll\InternetGetConnectedState", Str,flag, Int,0 )
    }
}
Return