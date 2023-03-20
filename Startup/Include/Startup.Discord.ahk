#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


updater:="Discord Updater ahk_exe DiscordPtb.exe"
discord:="ahk_exe DiscordPtb.exe"

Loop
{
    ; Check if connected to the internet
    If IsConnectedToInternet()
    {
        Run, shell:AppsFolder\com.squirrel.DiscordPtb.DiscordPtb,, Min

        WinWait, %updater%, , 10
        ; WinHide, %updater%

        WinWait, %discord%,,10, %updater%
        ; WinHide, %discord%,, %updater%
        ExitApp
    }
}
Return