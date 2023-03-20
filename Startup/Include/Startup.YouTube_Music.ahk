#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


Sleep, 10000

title:="YouTube Music ahk_exe YouTube Music.exe"
path:="shell:AppsFolder\com.github.th-ch.youtube-music"

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