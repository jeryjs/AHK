#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


title:="YouTube Music ahk_exe YouTube Music.exe"
path:="shell:AppsFolder\com.github.th-ch.youtube-music"

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