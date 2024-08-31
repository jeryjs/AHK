#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon


updater:="Discord Updater ahk_exe Discord.exe"
loading:="ahk_exe Discord.exe"
discord:="Friends - Discord ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe"

Loop
{
    ; Check if Discord is already running
    if WinExist("ahk_exe Discord.exe")
    {
        ExitApp
    }

    ; Check if connected to the internet
    If IsConnectedToInternet()
    {
        Run, shell:AppsFolder\com.squirrel.Discord.Discord,, Min

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