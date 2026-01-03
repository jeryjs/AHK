#Requires AutoHotkey v2
#SingleInstance Force
#MaxThreadsPerHotkey 1

if !A_IsAdmin
{
    ; MsgBox "This Script needs to run as Admin for best performance... So do that!!"
    Run '*RunAs "' A_ScriptFullPath '"'
}

game_id := "Genshin Impact ahk_class UnityWndClass ahk_exe GenshinImpact.exe"

; Create an auto-hiding ToolTip at cursor location
ToolTipEx(text, time := 1000, ToolTip_X := "", ToolTip_Y := "") {
    if (ToolTip_X = "") && (ToolTip_Y = "")
        MouseGetPos &ToolTip_X, &ToolTip_Y
    ToolTip text, ToolTip_X, ToolTip_Y
    SetTimer () => ToolTip(), -time
}

ControlClickToGame(pos_x, pos_y, delay, action, game_id := "Genshin Impact ahk_class UnityWndClass ahk_exe GenshinImpact.exe") {
    ToolTipEx(action, delay)
    WinActivate game_id
    Click("L", pos_x, pos_y)
    Sleep(delay)
}

ControlSendToGame(keys, delay, action, game_id := "Genshin Impact ahk_class UnityWndClass ahk_exe GenshinImpact.exe") {
    ToolTipEx(action, delay)
    WinActivate game_id
    Send(keys)
    Sleep(delay)
}

^!q:: { ; Press Ctrl+Alt+Q to start
    Loop 10 {
        ToolTipEx("Starting")
        ControlSendToGame("B", 1500, "Open menu")
        ControlClickToGame(1706, 48, 2000, "Click manage stages")
        ControlSendToGame("F", 100, "Select manage")
        ControlClickToGame(1324, 289, 100, "Click first stage")
        ControlClickToGame(1733, 1018, 100, "Click Delete")
        ControlClickToGame(1181, 758, 100, "Confirm x1")
        ControlClickToGame(1181, 758, 100, "Confirm x2")
        ; ControlSendToGame("{Esc}", 500, "Close dialog")
        ControlClickToGame(1706, 48, 750, "Click close dialog")
        ControlSendToGame("{Esc}", 1000, "Close menu")
        ControlClickToGame(1500, 835, 1500, "Click Hu Tao's Secret")
        ControlClickToGame(1516, 892, 22000, "Click start")
        ControlClickToGame(1716, 1020, 100, "Click Return to Lobby")
        Sleep 13000
    }
}

!Esc::ExitApp
!r::Reload
