GetActiveExplorerPath(hwnd:="") {
    if !hwnd
        hwnd := WinExist("A")
    activeTab := 0
    try ControlGet, activeTab, Hwnd,, % "ShellTabWindowClass1", % "ahk_id" hwnd
    for w in ComObjCreate("Shell.Application").Windows {
        if (w.hwnd != hwnd)
            continue
        if activeTab {
            static IID_IShellBrowser := "{000214E2-0000-0000-C000-000000000046}"
            shellBrowser := ComObjQuery(w, IID_IShellBrowser, IID_IShellBrowser)
            DllCall(NumGet(numGet(shellBrowser+0)+3*A_PtrSize), "Ptr", shellBrowser, "UInt*", thisTab)
            if (thisTab != activeTab)
                continue
            ObjRelease(shellBrowser)
        }
        return w.Document.Folder.Self.Path
    }
    return false
}