;-----------------------------------------------------------------------------------
;[Shift+Numpad4] Pi Agent Terminal
;-----------------------------------------------------------------------------------
; Fullscreen Windows Terminal running "pi --no-session".
; - If the window already exists  -> jump to it (toggle off if it is already up)
; - If it does not exist          -> UltraBossKey style splash, press 4 to launch it
; The window always lives on virtual desktop #1.
;-----------------------------------------------------------------------------------

; Both variants bound: with NumLock ON the key reports as Numpad4, with
; NumLock OFF the same physical key reports as NumpadLeft. Same pattern as the
; desktop-switch bindings (#Numpad4 / #NumpadLeft) in Hotkeys.ahk.
+Numpad4::
+NumpadLeft::
    global PiTitle, PiDesktopNum, PiWorkingDir, PiBin, PiProfile, LastActiveWindow, LastActiveDesktop
    ; Window title is deliberately a single unique token: AHK matches window titles as
    ; substrings, so "Pi Agent" would also catch any other window containing that text.
    PiTitle      := "PiAgentScratch-7f3a"
    PiDesktopNum := 4
    PiWorkingDir := "C:\Users\Jery\OneDrive\Desktop"
    PiBin        := "C:\Users\Jery\.pi\agent\bin\pi.cmd"
    PiProfile    := "Pi Agent" ; Windows Terminal *profile* name (carries opacity: 0). Distinct from the window title.
    if not WinActive(PiTitle) {
        LastActiveWindow := WinExist("A")
        LastActiveDesktop := VD.getCurrentDesktopNum()
        ; msgbox, %LastActiveWindow% - %LastActiveDesktop%
    }

    PiKey()
Return

PiKey() {
    if (WinExist(PiTitle)) {
        ; already running: jump to it, or toggle it off if it is already in front
        cur := VD.getCurrentDesktopNum()
        if (cur = PiDesktopNum && WinActive(PiTitle)) {
            ; WinHide, %PiTitle%
            ; MsgBox, %LastActiveWindow%
            VD.goToDesktopNum(LastActiveDesktop)
            WinActivate, %LastActiveWindow%
            Return
        }
        ; VD.goToDesktopNum(PiDesktopNum)
        Sleep, 150
        WinShow, %PiTitle%
        WinActivate, %PiTitle%
        Return
    }

    ; not running: splash + single keypress to launch (UltraBossKey pattern)
    ; Uses InputHook instead of the Input command: Input cannot capture the
    ; confirm key while the hotkey's Shift modifier is still held, and with NumLock
    ; off the numpad-4 key reports as Left, which emits no character for Input to
    ; record. End keys are given as explicit scan/virtual key codes so the physical
    ; key is matched regardless of NumLock state or which modifiers are held:
    ;   sc039 = numpad 4 (same physical key whether NumLock is on or off)
    ;   sc023 = main-row 4        vk25 = Left        vk34 = 4
    ; The V option keeps keystrokes flowing to the foreground window so a swallowed
    ; Shift key-up cannot leave modifiers logically stuck in another app.
    SplashTextOn, 300, 25, Pi Agent, Press '4' to open Pi agent
    PiSplashIH := InputHook("T1 L0 V", "{sc039}{sc023}{vk25}{vk34}")
    PiSplashIH.Start()
    PiSplashWhy := PiSplashIH.Wait(1)
    SplashTextOff
    if (PiSplashWhy = "EndKey")
        PiSpawn()
    Return
}

PiSpawn() {
    global PiTitle, PiDesktopNum, PiWorkingDir, PiBin, PiProfile
    Run, wt.exe -F -w new new-tab -p "%PiProfile%" --title "%PiTitle%" --suppressApplicationTitle -d "%PiWorkingDir%" "%PiBin%" --no-session
    WinWait, %PiTitle%, , 20
    if !ErrorLevel
        PiPlace()
    WinActivate, %PiTitle%
    Return
}

; Move the terminal onto desktop #1 without ever pulling the user there.
PiPlace() {
    global PiTitle, PiDesktopNum
    Loop 8 {
        VD.MoveWindowToDesktopNum(PiTitle, PiDesktopNum)
        Sleep, 120
    }
    Return
}
