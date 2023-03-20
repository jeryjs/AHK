#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


updater:="Discord Updater ahk_exe DiscordPtb.exe"
loading:="ahk_exe DiscordPTB.exe"
discord:="Friends - Discord ahk_class Chrome_WidgetWin_1 ahk_exe DiscordPTB.exe"

Loop
{
    ; Check if connected to the internet
    If IsConnectedToInternet()
    {
        Run, shell:AppsFolder\com.squirrel.DiscordPtb.DiscordPtb,, Min

        WinWait, %updater%,, 20
        WinHide, %updater%

        WinWait, %loading%,,20, %updater%
        WinHide, %loading%,, %updater%

        WinWait, %discord%,,20, %updater%
        WinHide, %discord%,, %updater%
        ExitApp
    }
}
Return