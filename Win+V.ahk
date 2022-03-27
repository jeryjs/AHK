;-------------------------------------------------------------------------------------------------------------------------
;[Win+V] Ditto
;-------------------------------------------------------------------------------------------------------------------------
#ifwinactive ahk_class QPasteClass
#v::sendinput {down}
#b::sendinput {up}
#Down::sendinput {down}
#Up::sendinput {up}
*RWIN up::
*LWIN up::
    send {enter}
return

#ifwinexist Ditto
#v::send {ctrl down}`;{ctrl up}

#ifwinnotexist Ditto
#v::run C:\Program Files\Ditto\Ditto.exe /Open