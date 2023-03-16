#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


updater:="Discord Updater ahk_exe Discord.exe"
discord:="ahk_exe Discord.exe"

Loop
{
    If ConnectedToInternet()
    {
        Run, "C:\Users\%A_UserName%\AppData\Local\Discord\Update.exe" --processStart Discord.exe,, Min

        WinWait, %updater%, , 10
        WinHide, %updater%

        WinWait, %discord%,,10, %updater%
        WinHide, %discord%,, %updater%
        ExitApp
    }
    ConnectedToInternet(flag=0x43)
    {
        Return DllCall("Wininet.dll\InternetGetConnectedState", Str,flag, Int,0 )
    }
}
Return