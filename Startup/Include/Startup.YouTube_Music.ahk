#NoEnv
#SingleInstance, Force
DetectHiddenWindows, On
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


Sleep, 5000

title:="ahk_class Chrome_WidgetWin_1 ahk_exe YouTube Music.exe"
path:="shell:AppsFolder\com.github.th-ch.youtube-music"

Loop
{
    ; Check if YouTube Music is already running
    if WinExist("ahk_exe YouTube Music.exe")
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