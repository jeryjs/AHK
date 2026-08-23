SetTitleMatchMode, 2 ; Crucial: Allows partial substring matching anywhere in the title
#Include Y:/Dev/AutoHotkey/Lib/Gdip_All.ahk

if !pToken := Gdip_Startup() 
    ExitApp
ExternalInput := "test.ahk"
Loop, Parse, ExternalInput, % " "
{
    WinGet, hwnd, ID, % SubStr(ExternalInput, 1, StrLen(ExternalInput) - (A_Index-1)*5)
    if (hwnd)
        break
}
if (!hwnd) {
    MsgBox, 48, Error, No active window match discovered.
    Gdip_Shutdown(pToken)
    ExitApp
}
pBitmap := Gdip_BitmapFromHWND_Chromium(hwnd)
msgBox, 64, Success, Screenshot captured successfully for window handle: %hwnd%
Gdip_SaveBitmapToFile(pBitmap, "C:\Users\jery\AppData\Local\Temp\pi_screen_capture.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
ExitApp


; --- FIX ENGINE ---
; Overrides standard GDI capturing to force-render Hardware Accelerated windows
Gdip_BitmapFromHWND_Chromium(hwnd) {
    WinGetPos,,, Width, Height, ahk_id %hwnd%
    hbm := CreateDIBSection(Width, Height)
    hdc := CreateCompatibleDC()
    obm := SelectObject(hdc, hbm)
    
    ; Flag 2 = PW_RENDERFULLCONTENT (Captures hardware-accelerated layouts)
    DllCall("PrintWindow", "Ptr", hwnd, "Ptr", hdc, "UInt", 2) 
    
    pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
    SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
    return pBitmap
}