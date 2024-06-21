#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
;@Ahk2Exe-SetMainIcon Z:\Documents\All-Projects\Vishal-Sir\CO-PO-Attainment\.venv\Lib\site-packages\win32\test\win32rcparser\python.ico

; Y:\Dev\AutoHotkey\Compiler\Ahk2Exe.exe /in Z:\Documents\All-Projects\bing-rewards\bing-rewards.ahk

Loop
{
    If IsConnectedToInternet()
        Break
}

class Browser {
    __New(path, title) {
        this.path := path
        this.title := title
    }
}

browsers := []
android := True

tempFile := A_Temp . "\bing-reward-android"
if FileExist(tempFile) {
    FileDelete, %tempFile%
} else {
    FileAppend, , %tempFile%
    android := False
}

if (android) {
    browsers.Push(new Browser("shell:AppsFolder\org.mozilla.fenix", "ahk_class org.mozilla.fenix ahk_exe WsaClient.exe"))
    browsers.Push(new Browser("shell:AppsFolder\org.mozilla.firefox_beta", "ahk_class org.mozilla.firefox_beta ahk_exe WsaClient.exe"))
    browsers.Push(new Browser("shell:AppsFolder\org.mozilla.firefox", "ahk_class org.mozilla.firefox ahk_exe WsaClient.exe"))
    browsers.Push(new Browser("shell:AppsFolder\org.mozilla.fennec_fdroid", "ahk_class org.mozilla.fennec_fdroid ahk_exe WsaClient.exe"))
} Else {    
    browsers.Push(new Browser("C:\Program Files (x86)\Microsoft\Edge Dev\Application\msedge.exe  https://www.bing.com/search?q=  https://rewards.bing.com/", "- Personal - Microsoft Edge Dev ahk_exe msedge.exe"))
    browsers.Push(new Browser("shell:AppsFolder\Mozilla.Firefox_n80bbvh6b1yt2!App", "— Mozilla Firefox ahk_exe firefox.exe"))
    browsers.Push(new Browser("shell:AppsFolder\CA9422711AE1A81C", "— Firefox Developer Edition ahk_exe firefox.exe"))
    browsers.Push(new Browser("C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe", "- Personal - Microsoft Edge Dev ahk_exe msedge.exe"))
}

for index, browser in browsers
{
    Run, % browser.path

    if (android) {
        WinWait, % browser.title,, 10
        ; WinWaitClose, % browser.title
        ; MsgBox, % "closed: " browser.title
    }
}

ExitApp