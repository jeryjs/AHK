#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
;@Ahk2Exe-SetMainIcon C:\Users\Jery\OneDrive\AHK\Hotkeys\imports\Settings-Icon.ico

; Y:\Dev\AutoHotkey\Compiler\Ahk2Exe.exe /in C:\Users\Jery\OneDrive\AHK\Bing-Rewards\bing-rewards.ahk

Loop
{
    If IsConnectedToInternet()
        Break
}


; Check for command-line argument
android := False
if (A_Args[1] = "android") {
    android := True
} Else If (A_Args[1] = "desktop") {
    android := False
} else {
    tempFile := A_Temp . "\bing-reward-android"
    if FileExist(tempFile) {
        FileDelete, %tempFile%
        android := True
    } else {
        FileAppend, , %tempFile%
        android := False
    }
}


RunBingRewards(name, paths) {
	SplashTextOn, 250, 25, Bing Rewards (%name%), Running Bing Rewards...
	searchTerms := ["anime", "manga", "light", "novels", "hinata", "nezuko", "demon", "slayer", "naruto", "attack", "on", "titan", "sakura", "tokyo", "kyoto", "osaka", "hokkaido", "fuji", "ramen", "sushi", "samurai", "shinto", "hentai", "kanji", "katakana", "hiragana", "jpop", "kawaii", "otaku", "cosplay", "gundam", "pokemon", "ghibli", "miyazaki", "harajuku", "shibuya", "akihabara", "ikebukuro", "yokohama", "nagoya", "sapporo", "fukuoka", "kobe", "shinjuku", "asakusa", "tsukiji", "ryokan", "onsen", "kimono", "yukata"]
	query := "https://www.bing.com/search?q="
	Random, loopCount, 1, 5
	Loop % loopCount {
		Random, randomIndex, 1, searchTerms.Length()
		randomWord := searchTerms[randomIndex]
		query .= randomWord . "%20"
	}
	query .= "&form=STARTSCRIPT"

	SysGet, MonitorWorkArea, MonitorWorkArea
	screenWidth := MonitorWorkAreaRight - MonitorWorkAreaLeft
	screenHeight := MonitorWorkAreaBottom - MonitorWorkAreaTop

	; Define position templates for different window counts using arrays
	posTemplates := []
	posTemplates.Insert([[0, 0, 1, 1]])  ; 1 window
	posTemplates.Insert([[0, 0, 0.5, 1], [0.5, 0, 0.5, 1]])  ; 2 windows
	posTemplates.Insert([[0, 0, 1/3, 1], [1/3, 0, 1/3, 1], [2/3, 0, 1/3, 1]])  ; 3 windows
	posTemplates.Insert([[0, 0, 0.5, 0.5], [0.5, 0, 0.5, 0.5], [0, 0.5, 0.5, 0.5], [0.5, 0.5, 0.5, 0.5]])  ; 4 windows
	posTemplates.Insert([[0, 0, 0.5, 0.5], [0.5, 0, 0.5, 0.5], [0.25, 0.25, 0.5, 0.5], [0, 0.5, 0.5, 0.5], [0.5, 0.5, 0.5, 0.5]])  ; 5 windows

	; Open all windows and then loop through them to reposition them
	; pids := []
	; For index, path in paths {
	; 	Run, %path% %query%,,,pid
	; 	pids.Push(pid)
	; }

	; WinWaitActive, ahk_exe msedge.exe,,1
	; Sleep, 1500
	
	; For index, path in paths {
	; 	if (paths.Length() > posTemplates.Length()) {
	; 		; Default behavior for more than 5 windows
	; 		row := Floor((index - 1) / 3)
	; 		col := Mod(index - 1, 3)
	; 		x := col * screenWidth / 3
	; 		y := row * screenHeight / 2
	; 		w := screenWidth / 3
	; 		h := screenHeight / 2
	; 	} else {
	; 		; Retrieve position from template
	; 		template := posTemplates[paths.Length()][index]
	; 		x := template[1] * screenWidth
	; 		y := template[2] * screenHeight
	; 		w := template[3] * screenWidth
	; 		h := template[4] * screenHeight
	; 	}
		
	; 	If (InStr(path, "wsa://")) {
	; 		pkgName := StrReplace(path, "wsa://")
	; 		; WinWaitActive, ahk_class %pkgName% ahk_exe WsaClient.exe,,30
	; 		; WinGet, winList, List, ahk_exe WsaClient.exe
	; 	} Else {
	; 		SplashTextOff
	; 		WinGet, winList, List, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
	; 		; MsgBox, % "ahk_id ".winList%index%
	; 		WinWait, % "ahk_id " . winList%index%,, 1
	; 		WinRestore, % "ahk_id " . winList%index%
	; 		WinMove, % "ahk_id " . winList%index%, , %x%, %y%, %w%, %h%
	; 	}
	; }


	; Loop through the paths and open the windows
	; MsgBox, % paths
	for index, path in paths {
		if (paths.Length() > posTemplates.Length()) {
			; Default behavior for more than 5 windows
			row := Floor((index - 1) / 3)
			col := Mod(index - 1, 3)
			x := col * screenWidth / 3
			y := row * screenHeight / 2
			w := screenWidth / 3
			h := screenHeight / 2
		} else {
			; Retrieve position from template
			template := posTemplates[paths.Length()][index]
			x := template[1] * screenWidth
			y := template[2] * screenHeight
			w := template[3] * screenWidth
			h := template[4] * screenHeight
		}
		
		; Run browser and adjust its position
		Run, %path% %query%
		Sleep, 400 ; Give some time for the window to open

		; Find the topmost window of the executable and reposition it
		If (InStr(path, "wsa://")) {
			pkgName := StrReplace(path, "wsa://")
			; WinWaitActive, ahk_class %pkgName% ahk_exe WsaClient.exe,,30
			; WinGet, winList, List, ahk_exe WsaClient.exe
		} Else {
			WinWaitActive, ahk_exe msedge.exe,,10
			WinGet, winList, List, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
		}

		if (winList) {
			; Use the first window in the list (topmost)
			WinRestore, ahk_id %winList1% ; Restore window if maximized
			WinMove, ahk_id %winList1%, , %x%, %y%, %w%, %h%
		}
	}
	
	ExitApp
}

edge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe --profile-directory="
If (!android)
	RunBingRewards("Desktop", [edge . """Profile 1""", edge . """Profile 2""", edge . """Profile 3""", edge . """Profile 6"""])	; RunBingRewards("Desktop", [edge . """Profile 1""", edge . """Profile 2""", edge . """Profile 3""", edge . """Profile 4""", edge . """Profile 5""", edge . """Profile 6"""])
Else
	RunBingRewards("Mobile", ["wsa://org.mozilla.fenix", "wsa://org.mozilla.firefox", "wsa://net.waterfox.android.release", "wsa://org.mozilla.firefox_beta", "wsa://io.github.forkmaintainers.iceraven", "wsa://org.mozilla.firefox123"])


Esc::ExitApp