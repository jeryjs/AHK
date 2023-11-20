; Battery Alarm
Battery_Tan_Success := 0
Battery_Check:
ListLines, Off
	VarSetCapacity(powerstatus, 1+1+1+1+4+4)
	success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)

	AC_Status:=ReadInteger(&powerstatus,0,1,false)
	Battery_Life:=ReadInteger(&powerstatus,2,1,false)
	If ((Battery_Tan_Success < 1) AND ( ((AC_Status = 1) AND (Battery_Life = 80)) OR ((AC_Status = 0) AND (Battery_Life = 40)) ) )
	{
		SoundPlay, %A_ScriptDir%\audios\Alarm02.wav
		IfWinNotActive, ahk_group game
			SplashImage, %A_ScriptDir%\images\Battery-Tan-665x245.jpg,b,
		Else
			TrayTip, Battery Tan~, Please take care of me (////), 1
		Sleep, 3000
		SplashImage, Off
		Battery_Tan_Success++
	}
	Else If ((Battery_Tan_Success = 1) AND ( ((Battery_Life = 86) OR (Battery_Life = 84)) OR ((Battery_Life = 41) OR (Battery_Life = 39)) ) )
		Battery_Tan_Success := 0
		
	If ((Battery_Life = 10) AND (AC_Status = 0))
	{
		Loop, 10 {
			SplashImage, %A_ScriptDir%\images\Battery-Tan-665x245.jpg,b,
			Sleep, 100
			SplashImage, Off
			If AC_Status = 1
				Break
		} Until AC_Status = 1
		SplashImage, Off
	}
Return

#If