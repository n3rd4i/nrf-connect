#NoEnv
#NoTrayIcon
#Warn
SendMode Input
SetTitleMatchMode, 2
SetControlDelay 0
SetWorkingDir %A_ScriptDir%

WinWait,nRF Connect Uninstall ahk_class #32770 ahk_exe ahk_exe Un_A.exe,, 180
ControlSend,Button1,{SPACE},nRF Connect Uninstall ahk_class #32770 ahk_exe ahk_exe Un_A.exe
